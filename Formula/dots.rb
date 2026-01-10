class Dots < Formula
  desc "Minimal task tracker for AI agents - plain markdown files, no database"
  homepage "https://github.com/joelreymont/dots"
  version "0.5.4"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/joelreymont/dots/releases/download/v0.5.4/dot-macos-arm64"
      sha256 "8eb685b4cf4c94dc22517f6877e6beafae9df8a67d8b05a44a2b08f7d0645916"
    end
    on_intel do
      odie "Intel Mac binaries not available. Please build from source."
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/joelreymont/dots/releases/download/v0.5.4/dot-linux-x86_64"
      sha256 "a7bb96cee66b900e7a1214715c175a0ac180bc14e5de36d5dd47c4739517f4e6"
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
