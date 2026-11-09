# Bumped by aislopware/onicode scripts/release/publish.sh after each macOS release: it rewrites the
# `version` (app version, better-update release id) and `sha256` lines below. Keep both at two-space
# indentation and one per file or that sed stops matching.
cask "onicode" do
  version "0.4.0,c0372f4c-45b6-4447-8c52-1d4acaf32fa1"
  sha256 "f4e8b890f6e5fb5d2eed8d3c66cdb4efd2e97d9d4948225481399efbdf2eec96"

  url "https://updates.jmango360.dev/feeds/59625ece-aea5-49b4-8978-1f045f907d92/macos/download/#{version.csv.second}/Onicode-#{version.csv.first}-arm64.zip"
  name "Onicode"
  desc "GUI for coding agents: Claude Code, Codex, Cursor, OpenCode and more"
  homepage "https://github.com/aislopware/onicode"

  livecheck do
    url "https://updates.jmango360.dev/feeds/59625ece-aea5-49b4-8978-1f045f907d92/macos/latest-mac.yml"
    regex(%r{download/([^/]+)/Onicode[._-]v?(\d+(?:\.\d+)+)-arm64\.zip}i)
    strategy :page_match do |page, regex|
      page.scan(regex).map { |match| "#{match[1]},#{match[0]}" }
    end
  end

  # The app updates itself from the same better-update feed (electron-updater).
  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :ventura

  app "Onicode.app"

  # `onicode service install` registers this agent; it runs the server from inside the app bundle.
  uninstall launchctl: "dev.aislopware.onicode.service",
            quit:      "dev.aislopware.onicode"

  zap trash: [
    "~/.onicode",
    "~/Library/Application Support/onicode-v2",
    "~/Library/Caches/dev.aislopware.onicode",
    "~/Library/Caches/dev.aislopware.onicode.ShipIt",
    "~/Library/Caches/onicode-updater",
    "~/Library/HTTPStorages/dev.aislopware.onicode",
    "~/Library/Preferences/dev.aislopware.onicode.plist",
    "~/Library/Saved Application State/dev.aislopware.onicode.savedState",
  ]
end
