class Dots < Formula
  desc "Minimal task tracker for AI agents - plain markdown files, no database"
  homepage "https://github.com/joelreymont/dots"
  version "0.6.4"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/joelreymont/dots/releases/download/v0.6.4/dot-macos-arm64"
      sha256 "a8f749aba34d90ada89e81a3b29096381361c410289f06c6e864db28825d1fbc"
    end
    on_intel do
      odie "Intel Mac binaries not available. Please build from source."
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/joelreymont/dots/releases/download/v0.6.4/dot-linux-x86_64"
      sha256 "2008db695f375ca29475b82250c5d71d51c8e3ed0f63ffcaf710a6628c5ce578"
    end
  end

  def install
    binary_name = if OS.mac? && Hardware::CPU.arm?
      "dot-macos-arm64"
    elsif OS.linux? && Hardware::CPU.intel?
      "dot-linux-x86_64"
    end
    bin.install binary_name => "dot" if binary_name
  end

  def caveats
    <<~EOS
      To migrate from beads (SQLite), download and run the migration script:
        curl -LO https://github.com/joelreymont/dots/releases/latest/download/migrate-dots.sh
        chmod +x migrate-dots.sh
        ./migrate-dots.sh

      Requirements: sqlite3, jq
    EOS
  end

  test do
    assert_match "dots", shell_output("#{bin}/dot --version")
  end
end
