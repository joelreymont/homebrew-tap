class Dot < Formula
  desc "Minimal task tracker for AI agents - like beads, but smaller and faster"
  homepage "https://github.com/joelreymont/dots"
  version "0.3.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/joelreymont/dots/releases/download/v0.3.2/dot-macos-arm64"
      sha256 "a001e8d30b86755f203d96d847640e8f98af3a5649be1aefe50ed1b949b8b462"
    end
    on_intel do
      odie "Intel Mac binaries not available. Please build from source."
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/joelreymont/dots/releases/download/v0.3.2/dot-linux-x86_64"
      sha256 "0596e03f9236450a774b8831fe3cecb69b79e47f518b02cef54154a0238dabe2"
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
