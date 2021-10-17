require 'cgi'
require 'json'
require 'shellwords'
require 'open3'

class GithubGrep
  VERSION = "0.0.0"

  def initialize(token)
    @token = token
  end

  def render_search(q, type)
    search(q, type) do |items|
      if type == :issues
        yield issue_items_to_lines(items)
      else
        yield code_items_to_lines(items)
      end
    end
  end

  def search(q, type, &block)
    headers = ["-H", "Accept: application/vnd.github.v3.text-match+json"]
    url = "https://api.github.com/search/#{type}?q=#{CGI.escape(q)}"
    all_pages(url, per_page: 100, argv: headers, &block)
  end

  private

  def code_items_to_lines(items)
    items.flat_map do |item|
      file = item.fetch('repository').fetch('name') + ":" + item.fetch('path')
      lines(item).map { |l| "#{file}: #{l}" }
    end
  end

  def issue_items_to_lines(items)
    items.flat_map do |item|
      number = item.fetch("number")
      lines(item).map { |l| "##{number}: #{l}" }
    end
  end

  def lines(item)
    item.fetch("text_matches").flat_map { |match| match.fetch('fragment').split("\n") }
  end

  def all_pages(url, per_page:, **kwargs)
    page = 1
    connector = (url.include?("?") ? "&" : "?")
    loop do
      response = request_json("#{url}#{connector}per_page=#{per_page}&page=#{page}", **kwargs)
      hash = response.is_a?(Hash)
      if page == 1 && hash && total = response["total_count"]
        $stderr.puts "Found #{total}"
      else
        $stderr.puts "Page #{page}"
      end

      items = (hash ? response.fetch('items') : response)
      yield items

      break if items.size < per_page
      page += 1
    end
  end

  def request_json(url, argv: [])
    # NOTE: github returns a 403 with a Retry-After: 60 on page 3+ ... talking with support atm but might have to handle it
    command = ["curl", "-sSfv", "-H", "Authorization: token #{@token}", *argv, url]

    out, err, status = Open3.capture3(*command)

    # 403 Abuse rate limit often has no Retry-After
    retry_after = err[/Retry-After: (\d+)/, 1]
    abuse_limit = err.include?("returned error: 403")
    if retry_after || abuse_limit
      retry_after ||= "20"
      warn "Sleeping #{retry_after} to avoid abuse rate-limit"
      sleep Integer(retry_after)
      out, err, status = Open3.capture3(*command)
    end

    raise "ERROR Request failed\n#{url}\n#{err}\n#{out}" unless status.success?

    JSON.parse(out)
  end
end
