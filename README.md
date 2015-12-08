makes github search grep and pipeable

 - create a [application token](https://github.com/settings/applications) with read access
 - clone repo
 - follow script instructions

```
bundle
bundle exec ruby github-grep.rb 'user:my-rog something-bad' | grep 'narrow-it-down' | grep -v 'something good'
```
