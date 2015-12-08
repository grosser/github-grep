makes github search grep and pipeable

```
bundle
bundle exec ruby github-grep.rb 'user:my-rog something-bad' | grep 'narrow-it-down' | grep -v 'something good'
```
