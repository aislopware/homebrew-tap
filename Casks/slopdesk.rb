# Bumped automatically by aislopware/slop-desk .github/workflows/release.yml (the `tap` job),
# which rewrites the `version` and `sha256` lines below. Keep both at two-space indentation and
# one per file or that sed stops matching.
cask "slopdesk" do
  version "0.1.0"
  sha256 "9dfbb52c1309c323723c4a8b6699ce34784d4fd7275670cc096b432f4521b1a5"

  url "https://github.com/aislopware/slop-desk/releases/download/v#{version}/SlopDesk-#{version}-arm64.dmg"
  name "SlopDesk"
  desc "Low-latency remote coding for macOS: the client viewer and the host menu-bar app"
  homepage "https://github.com/aislopware/slop-desk"

  # See the formula for why arm64 is a hard requirement rather than a default.
  depends_on arch: :arm64
  depends_on macos: ">= :tahoe"

  app "SlopDesk.app"
  app "SlopDeskHost.app"

  caveats <<~EOS
    SlopDeskHost needs Screen Recording and Accessibility (System Settings -> Privacy &
    Security). macOS keys both grants to the code signature, so they survive an upgrade in
    place -- but an unsigned local build of the same app will not inherit them.

    SlopDesk.app offers to symlink its bundled command-line tool to /usr/local/bin/slopdesk on
    first launch. If you also run `brew install slopdesk`, decline that offer: the formula's
    copy in the Homebrew prefix takes precedence on PATH and the two would drift apart.
  EOS

  zap trash: [
    "~/Library/Application Support/SlopDesk",
    "~/Library/Containers/com.slopdesk.client.macos",
    "~/Library/Preferences/com.slopdesk.client.macos.plist",
    "~/Library/Preferences/com.slopdesk.host.macos.plist",
    "~/Library/Saved Application State/com.slopdesk.client.macos.savedState",
  ]
end
