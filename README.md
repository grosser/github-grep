makes github search grep and pipeable

 - create a [application token](https://github.com/settings/applications) with read access
 - clone repo
 - follow script instructions

```
bundle

# search code:
bundle exec ruby github-grep.rb 'user:grosser unicorn' | grep 'narrow-it-down' | grep -v 'something good'

# search issues and PR comments:
bundle exec ruby github-grep.rb 'repo:kubernetes/kubernetes network error' --issues | grep 'narrow-it-down' | grep -v 'something good'
```
