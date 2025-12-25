class Dot < Formula
  desc "Minimal task tracker for AI agents - like beads, but smaller and faster"
  homepage "https://github.com/joelreymont/dots"
  version "0.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/joelreymont/dots/releases/download/v0.2.0/dot-macos-arm64"
      sha256 "d9823da3b5fd157d0c2f342c8195faaecacf0ff1926c3db983d1c50da89e8c10"
    end
    on_intel do
      # Not yet available - build from source
      odie "Intel Mac binaries not available. Please build from source."
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/joelreymont/dots/releases/download/v0.2.0/dot-linux-x86_64"
      sha256 "8cf4b79fa202759df3e8fbcb124192773a9aec82b6c004b6ae29894e9ab0cebc"
    end
  end

  def install
    binary_name = if OS.mac? && Hardware::CPU.arm?
      "dot-macos-arm64"
    elsif OS.linux? && Hardware::CPU.intel?
      "dot-linux-x86_64"
    end

    if binary_name
      bin.install binary_name => "dot"
    end
  end

  test do
    assert_match "dots", shell_output("#{bin}/dot --version")
  end
end
