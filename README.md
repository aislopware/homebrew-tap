# aislopware/homebrew-tap

Homebrew tap for [SlopDesk](https://github.com/aislopware/slop-desk).

```bash
brew install aislopware/tap/slopdesk         # slopdesk, slopdesk-hostd, slopdesk-ctl
brew install --cask aislopware/tap/slopdesk  # SlopDesk.app + SlopDeskHost.app
```

Two packages sharing one name, installed independently. The cask's one command brings up both
apps (client and host); the formula's brings all three command-line tools. The app bundles carry
no copy of the CLI, so wanting both means running both commands.

**Apple silicon only, macOS 26 (Tahoe) or newer.** Not a packaging shortcut: the client links
libghostty, which is built with a `macos-arm64` slice and no other, and the apps deploy against
macOS 26 — a version no Intel Mac runs.

Both artifacts are signed with the WEEBUILD VIET NAM COMPANY LIMITED Developer ID and notarized
by Apple.

## This tap is machine-maintained

`version` and `sha256` in `Formula/slopdesk.rb` and `Casks/slopdesk.rb` are rewritten by the
`tap` job in `aislopware/slop-desk`'s `.github/workflows/release.yml` on every release. Edit
anything else you like; leave those two lines one-per-file at two-space indentation, or the
bump stops matching and releases silently stop updating the tap.
