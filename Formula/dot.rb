class Dot < Formula
  desc "Minimal task tracker for AI agents - like beads, but smaller and faster"
  homepage "https://github.com/joelreymont/dots"
  version "0.3.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/joelreymont/dots/releases/download/v0.3.1/dot-macos-arm64"
      sha256 "1f2893cd8efff93ee98224039ad9cab4ce0c86bfb65fe6a752931d4e9b95da57"
    end
    on_intel do
      odie "Intel Mac binaries not available. Please build from source."
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/joelreymont/dots/releases/download/v0.3.1/dot-linux-x86_64"
      sha256 "0b6a9be3e5ccead1d7c904a580fa158b81f342976fd3d08c5b9aba776b2a2e1b"
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
