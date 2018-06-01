makes github search grep and pipeable

 - create a [application token](https://github.com/settings/applications) with read access
 - clone repo
 - follow script instructions

```
bundle

# search code:
bin/github-grep 'user:grosser unicorn' | grep 'narrow-it-down' | grep -v 'something good'

# search issues and PR comments:
bin/github-grep 'repo:kubernetes/kubernetes network error' --issues | grep 'narrow-it-down' | grep -v 'something good'
```

NOTE: there are random 403 errors on the last page of a search (usually empty anyway), contacted github support about that :/
