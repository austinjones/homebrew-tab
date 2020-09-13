# Homebrew Tap: austinjones/taps

## How do I install the tab formula?
`brew install austinjones/taps/tab`

Or `brew tap austinjones/taps` and then `brew install tab`.

## Building the bottles
```
$ cd /usr/local/Homebrew/Library/Taps/austinjones/homebrew-taps/
$ git pull
$ brew upgrade austinjones/taps/tab
$ brew remove tab && brew test-bot --root-url=https://dl.bintray.com/austinjones/bottles-taps --bintray-org=austinjones --tap=austinjones/taps austinjones/taps/tab --skip-setup && HOMEBREW_BINTRAY_USER=austinjones HOMEBREW_BINTRAY_KEY=API-KEY brew pr-upload --bintray-org=austinjones --root-url=https://dl.bintray.com/austinjones/bottles-taps
$ cd /usr/local/Homebrew/Library/Taps/austinjones/homebrew-taps/
$ git push
```

## Documentation
`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).
