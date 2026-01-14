class Dots < Formula
  desc "Minimal task tracker for AI agents - plain markdown files, no database"
  homepage "https://github.com/joelreymont/dots"
  version "0.6.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/joelreymont/dots/releases/download/v0.6.1/dot-macos-arm64"
      sha256 "79a3118ee3dee411f44e5c5ab2a329293453c1f4f353735ca9a64b51ab5623c4"
    end
    on_intel do
      odie "Intel Mac binaries not available. Please build from source."
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/joelreymont/dots/releases/download/v0.6.1/dot-linux-x86_64"
      sha256 "549f4a4aa9d0f9c25ac7d19753b237677e5c2b42c689ff994eda9c84aa2edade"
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
