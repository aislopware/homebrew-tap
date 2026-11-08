# Bumped by aislopware/onicode scripts/release/publish.sh, which rewrites the `version` and `sha256` lines
# below once the release workflow has put the version's zip on its GitHub release. Keep both at two-space
# indentation and one per file or that sed stops matching.
cask "onicode" do
  version "0.3.0"
  sha256 "9d350c3ee28b2255e5ea59947bdd8151ab4f0ddcddfea46e7cff98b2a50fd43d"

  url "https://github.com/aislopware/onicode/releases/download/v#{version}/Onicode-#{version}-arm64.zip"
  name "Onicode"
  desc "Native control plane for coding agents across your Macs"
  homepage "https://github.com/aislopware/onicode"

  # Stable releases only; betas are opted into inside the app (Settings > General > Channel).
  livecheck do
    url :url
    strategy :github_latest
  end

  # The app replaces itself from its release feed, checking each zip's digest and Developer ID signature, so
  # `brew upgrade` leaves it alone unless asked with --greedy.
  auto_updates true
  # Apple silicon only: macOS 27.2, the app's floor (LSMinimumSystemVersion), runs on nothing else.
  depends_on arch: :arm64
  depends_on macos: :golden_gate

  app "Onicode.app"

  # The desktop helper is an SMAppService agent with KeepAlive, so its job goes before it is quit. The engine
  # (Contents/MacOS/Onicode Engine) outlives the app's windows by design and is no bundle `quit` can name; it
  # stops here so nothing keeps running from a removed bundle.
  uninstall launchctl: "dev.aislopware.onicode.desktop",
            quit:      [
              "dev.aislopware.onicode",
              "dev.aislopware.onicode.desktop",
            ],
            script:    {
              executable:   "/usr/bin/pkill",
              args:         ["-TERM", "-x", "Onicode Engine"],
              must_succeed: false,
            }

  zap trash: [
    "~/Library/Application Support/Onicode Desktop",
    "~/Library/Application Support/Onicode",
    "~/Library/Caches/dev.aislopware.onicode",
    "~/Library/Caches/Onicode Desktop",
    "~/Library/Caches/Onicode",
    "~/Library/HTTPStorages/dev.aislopware.onicode",
    "~/Library/Logs/Onicode",
    "~/Library/Preferences/dev.aislopware.onicode.desktop.plist",
    "~/Library/Preferences/dev.aislopware.onicode.plist",
    "~/Library/Saved Application State/dev.aislopware.onicode.savedState",
  ]
end
