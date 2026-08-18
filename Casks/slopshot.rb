# Bumped automatically by aislopware/slop-shot .github/workflows/release.yml (the `tap` job),
# which rewrites the `version` and `sha256` lines below. Keep both at two-space indentation and
# one per file or that sed stops matching.
#
# 0.0.0 with a zeroed digest is the pre-first-release placeholder: the URL it builds does not
# exist yet, so the failure is a 404 rather than a wrong app. The first tag pushed replaces both.
cask "slopshot" do
  version "0.0.0"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"

  url "https://github.com/aislopware/slop-shot/releases/download/v#{version}/SlopShot-#{version}-universal.dmg"
  name "SlopShot"
  desc "Native macOS screenshot and screen-recording tool with an annotation and video editor"
  homepage "https://github.com/aislopware/slop-shot"

  # No `depends_on arch:` — the DMG is universal (arm64 + x86_64). Intel Macs run macOS 15, so
  # there is no reason to drop them. Sequoia matches LSMinimumSystemVersion in Support/Info.plist.
  depends_on macos: ">= :sequoia"

  app "SlopShot.app"

  caveats <<~EOS
    SlopShot is a menu-bar app with no Dock icon -- look for the "S" in the menu bar.

    It needs Screen Recording (capture, recording) and Accessibility (scrolling capture, global
    hotkeys) under System Settings -> Privacy & Security, plus Microphone if you record voice.
    macOS keys those grants to the code signature, so they survive an upgrade in place -- but an
    unsigned local build of the same app will not inherit them.

    Sticker packs are downloaded on demand from the sticker store inside the app; none of them
    ship in this cask.
  EOS

  zap trash: [
    "~/Library/Application Support/SlopShot",
    "~/Library/Preferences/com.thanglb.slopshot.plist",
    "~/Library/Saved Application State/com.thanglb.slopshot.savedState",
  ]
end
