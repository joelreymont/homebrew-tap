class Dots < Formula
  desc "Minimal task tracker for AI agents - plain markdown files, no database"
  homepage "https://github.com/joelreymont/dots"
  version "0.5.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/joelreymont/dots/releases/download/v0.5.0/dot-macos-arm64"
      sha256 "46f7e70ed8a56a11e5743a85f761245aadb32e6e894b2b7fb0b33a18a99653fe"
    end
    on_intel do
      odie "Intel Mac binaries not available. Please build from source."
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/joelreymont/dots/releases/download/v0.5.0/dot-linux-x86_64"
      sha256 "3d25a7d067449de58001e70a908f9f9180776bf19d554c25b615efa94ec29c3c"
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

  test do
    assert_match "dots", shell_output("#{bin}/dot --version")
  end
end
