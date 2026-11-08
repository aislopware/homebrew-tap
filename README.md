# aislopware/homebrew-tap

Homebrew tap for [Onicode](https://github.com/aislopware/onicode),
[SlopDesk](https://github.com/aislopware/slop-desk) and
[SlopShot](https://github.com/aislopware/slop-shot).

```bash
brew install aislopware/tap/slopdesk         # slopdesk, slopdesk-hostd, slopdesk-ctl
brew install --cask aislopware/tap/slopdesk  # SlopDesk.app + SlopDeskHost.app
brew install --cask aislopware/tap/slopshot  # SlopShot.app
brew install --cask aislopware/tap/onicode   # Onicode.app
```

Everything here is signed with a Developer ID and notarized by Apple, with the ticket stapled to
each `.app` — so a first launch works offline: SlopDesk and SlopShot with WEEBUILD VIET NAM
COMPANY LIMITED's, Onicode with JMANGO VIETNAM OPERATIONS COMPANY LIMITED's (UK58J62H8L).

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

## Onicode

A native control plane for coding agents: many Macs, one app, peer to peer over your tailnet.

**Apple silicon only, macOS 27.2 or newer**, the app's floor. Onicode updates itself from its
release feed (checking each download's digest and Developer ID signature), so the cask is
`auto_updates` and `brew upgrade` leaves it alone unless asked with `--greedy`. The cask follows
stable releases; Beta is a channel chosen inside the app.

## This tap is machine-maintained

`version` and `sha256` in `Formula/slopdesk.rb`, `Casks/slopdesk.rb` and `Casks/slopshot.rb` are
rewritten by the `tap` job in each product repo's `.github/workflows/release.yml` on every
release; `Casks/onicode.rb`'s by onicode's `scripts/release/publish.sh`. Edit anything else you like; leave those two lines one-per-file at two-space
indentation, or the bump stops matching and releases silently stop updating the tap.
