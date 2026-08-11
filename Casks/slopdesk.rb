# Bumped automatically by aislopware/slop-desk .github/workflows/release.yml (the `tap` job),
# which rewrites the `version` and `sha256` lines below. Keep both at two-space indentation and
# one per file or that sed stops matching.
cask "slopdesk" do
  version "0.2.2"
  sha256 "9e18a50cd0ae947fe452141a33cc2213dd28c89bd86310ec022cc3a54a0f09e7"

  url "https://github.com/aislopware/slop-desk/releases/download/v#{version}/SlopDesk-#{version}-arm64.dmg"
  name "SlopDesk"
  desc "Low-latency remote coding for macOS: the client viewer and the host menu-bar app"
  homepage "https://github.com/aislopware/slop-desk"

  # See the formula for why arm64 is a hard requirement rather than a default.
  depends_on arch: :arm64
  depends_on macos: :tahoe

  app "SlopDesk.app"
  app "SlopDeskHost.app"

  caveats <<~EOS
    SlopDeskHost needs Screen Recording and Accessibility (System Settings -> Privacy &
    Security). macOS keys both grants to the code signature, so they survive an upgrade in
    place -- but an unsigned local build of the same app will not inherit them.

    This cask installs the two app bundles only. The command-line tools (slopdesk,
    slopdesk-hostd, slopdesk-ctl) are a separate package: `brew install slopdesk`. SlopDesk.app
    carries no copy of the CLI, so its first-launch "Install the CLI" card has nothing to link.
  EOS

  zap trash: [
    "~/Library/Application Support/SlopDesk",
    "~/Library/Containers/com.slopdesk.client.macos",
    "~/Library/Preferences/com.slopdesk.client.macos.plist",
    "~/Library/Preferences/com.slopdesk.host.macos.plist",
    "~/Library/Saved Application State/com.slopdesk.client.macos.savedState",
  ]
end
