# aislopware's flyline (https://github.com/aislopware/flyline), a standalone continuation of
# HalFrgrd/flyline. Built from source; `brew install --HEAD aislopware/tap/flyline` builds master.
# Shares the name with homebrew-core's `flyline`, which installs the same lib/bash/flyline file —
# uninstall that one first.
class Flyline < Formula
  desc "Bash plugin that replaces readline: highlighting, autosuggestions, fuzzy history"
  homepage "https://github.com/aislopware/flyline"
  url "https://github.com/aislopware/flyline/archive/refs/tags/v2.0.3.tar.gz"
  sha256 "fe7c88e89e47d32d53436217949a20ec1b8826885376f874f80dfc5448dbe361"
  license any_of: ["GPL-3.0-only", "MIT"]
  head "https://github.com/aislopware/flyline.git", branch: "master"

  depends_on "rust" => :build
  depends_on "bash" => :test

  def install
    cargo_args = std_cargo_args.reject { |arg| arg["--root"] || arg["--path"] }
    system "cargo", "build", "--lib", "--release", *cargo_args
    (lib/"bash").install shared_library("target/release/libflyline") => "flyline"
  end

  def caveats
    <<~EOS
      Load it from an interactive Homebrew bash (macOS's /bin/bash 3.2 cannot load builtins):
        enable -f #{HOMEBREW_PREFIX}/lib/bash/flyline flyline
    EOS
  end

  test do
    require "io/console"
    require "pty"

    output_log = testpath/"output.log"
    PTY.spawn(formula_opt_bin("bash")/"bash", "--noprofile", "--norc", "-i",
              [:out, :err] => output_log.to_s) do |r, w, pid|
      r.winsize = [80, 130]
      w.puts "enable -f #{lib}/bash/flyline flyline"
      w.puts "flyline version"
      w.puts "exit"
      r.read
    rescue Errno::EIO
      # GNU/Linux raises EIO when read is done on closed pty
    ensure
      r.close
      w.close
      Process.wait(pid)
    end

    assert_match version.to_s, output_log.read
  end
end
