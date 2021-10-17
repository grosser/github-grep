makes github search grep and pipeable

First create a [application token](https://github.com/settings/applications) with read access + enable SSO if available.

```
gem install github-grep

export GITHUB_TOKEN=<your token>
# or: git config github.token <your token>

# search code:
github-grep 'user:grosser unicorn' | grep 'dictionary' | grep -v 'higher'

# search issues and PR comments:
github-grep 'repo:kubernetes/kubernetes network error' --issues | grep 'narrow-it-down' | grep -v 'something good'
```

NOTE: there are random 403 errors on the last page of a search (usually empty anyway), contacted github support about that :/
