class Dots < Formula
  desc "Minimal task tracker for AI agents - plain markdown files, no database"
  homepage "https://github.com/joelreymont/dots"
  version "0.6.4"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/joelreymont/dots/releases/download/v0.6.4/dot-macos-arm64"
      sha256 "e60ec762d45e3f4e07f58d06b4456f5c84e67960b32fe48d1ecce50aeb1c3b67"
    end
    on_intel do
      odie "Intel Mac binaries not available. Please build from source."
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/joelreymont/dots/releases/download/v0.6.4/dot-linux-x86_64"
      sha256 "26bd0d35af76d6a16b7a056229b5579604984c8deb52d673d387b54faa5efa5c"
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
