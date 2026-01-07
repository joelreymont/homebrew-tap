class Dots < Formula
  desc "Minimal task tracker for AI agents - plain markdown files, no database"
  homepage "https://github.com/joelreymont/dots"
  version "0.5.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/joelreymont/dots/releases/download/v0.5.0/dot-macos-arm64"
      sha256 "1a36d02d226582e263d9d9e314406b3ba15f74614b06d70ddd36b3ce8e0e481c"
    end
    on_intel do
      odie "Intel Mac binaries not available. Please build from source."
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/joelreymont/dots/releases/download/v0.5.0/dot-linux-x86_64"
      sha256 "ca5eacbf6423c29f4406984782fcf9dfc68ce86dabd7b18fcd8b07cb9022288e"
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
