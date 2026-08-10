# Bumped automatically by aislopware/slop-desk .github/workflows/release.yml (the `tap` job),
# which rewrites the `version` and `sha256` lines below. Keep both at two-space indentation and
# one per file or that sed stops matching.
class Slopdesk < Formula
  desc "Low-latency remote coding: SlopDesk host daemon and command-line tools"
  homepage "https://github.com/aislopware/slop-desk"
  version "0.2.0"
  url "https://github.com/aislopware/slop-desk/releases/download/v#{version}/slopdesk-cli-#{version}-arm64.tar.gz"
  sha256 "408bbe534ca4fe153b49f66ce12726c09a0f9ce79e97e678f80266997bcc7f82"
  license "MIT"

  # Apple silicon only, and not by preference: the client links libghostty, which ships a
  # macos-arm64 slice and nothing else, and the apps deploy against macOS 26 — which no Intel
  # Mac runs. The CLI is built from the same tree and released as one arm64 artifact.
  depends_on arch: :arm64
  depends_on macos: :tahoe

  def install
    bin.install "slopdesk", "slopdesk-hostd", "slopdesk-ctl"
  end

  def caveats
    <<~EOS
      slopdesk-hostd forks your login shell over a PTY and listens for inbound connections.
      There is no app-layer authentication by design — reach it over a private WireGuard
      mesh, never over an address the public internet can route to.

      This formula is the only source of the command-line tools. The cask ships the two app
      bundles and nothing else — SlopDesk.app carries no copy of `slopdesk` inside it — so the
      app's first-launch "Install the CLI" card has nothing to link and reports so.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/slopdesk version")
    assert_match "usage: slopdesk-ctl", shell_output("#{bin}/slopdesk-ctl --help")
  end
end
