# Bumped automatically by aislopware/slop-desk .github/workflows/release.yml (the `tap` job),
# which rewrites the `version` and `sha256` lines below. Keep both at two-space indentation and
# one per file or that sed stops matching.
class Slopdesk < Formula
  desc "Low-latency remote coding: SlopDesk host daemon and command-line tools"
  homepage "https://github.com/aislopware/slop-desk"
  version "0.1.0"
  url "https://github.com/aislopware/slop-desk/releases/download/v#{version}/slopdesk-cli-#{version}-arm64.tar.gz"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"
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

      The SlopDesk client app (brew install --cask slopdesk) offers to symlink its own bundled
      copy to /usr/local/bin/slopdesk on first launch. Decline it, or this formula's binary in
      #{HOMEBREW_PREFIX}/bin will shadow it and the two can drift apart.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/slopdesk version")
    assert_match "usage: slopdesk-ctl", shell_output("#{bin}/slopdesk-ctl --help")
  end
end
