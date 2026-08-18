# aislopware/homebrew-tap

Homebrew tap for [SlopDesk](https://github.com/aislopware/slop-desk) and
[SlopShot](https://github.com/aislopware/slop-shot).

```bash
brew install aislopware/tap/slopdesk         # slopdesk, slopdesk-hostd, slopdesk-ctl
brew install --cask aislopware/tap/slopdesk  # SlopDesk.app + SlopDeskHost.app
brew install --cask aislopware/tap/slopshot  # SlopShot.app
```

Everything here is signed with the WEEBUILD VIET NAM COMPANY LIMITED Developer ID and notarized
by Apple, with the ticket stapled to each `.app` — so a first launch works offline.

## SlopDesk

Two packages sharing one name, installed independently. The cask's one command brings up both
apps (client and host); the formula's brings all three command-line tools. The app bundles carry
no copy of the CLI, so wanting both means running both commands.

**Apple silicon only, macOS 26 (Tahoe) or newer.** Not a packaging shortcut: the client links
libghostty, which is built with a `macos-arm64` slice and no other, and the apps deploy against
macOS 26 — a version no Intel Mac runs.

## SlopShot

Screenshots, screen recording, annotation and a video editor, in one menu-bar app.

**Universal (Apple silicon + Intel), macOS 15 (Sequoia) or newer.** The DMG carries both slices,
and Intel Macs run macOS 15, so the cask declares no `depends_on arch:`.

## This tap is machine-maintained

`version` and `sha256` in `Formula/slopdesk.rb`, `Casks/slopdesk.rb` and `Casks/slopshot.rb` are
rewritten by the `tap` job in each product repo's `.github/workflows/release.yml` on every
release. Edit anything else you like; leave those two lines one-per-file at two-space
indentation, or the bump stops matching and releases silently stop updating the tap.
