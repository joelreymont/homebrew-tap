class Dot < Formula
  desc "Minimal task tracker for AI agents - like beads, but smaller and faster"
  homepage "https://github.com/joelreymont/dots"
  version "0.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/joelreymont/dots/releases/download/v0.2.0/dot-macos-arm64"
      sha256 "300d0d5e56052017924fdebad7bea19a59f31c5666edefa5aced9d8993f48568"
    end
    on_intel do
      odie "Intel Mac binaries not available. Please build from source."
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/joelreymont/dots/releases/download/v0.2.0/dot-linux-x86_64"
      sha256 "b33285a08d5ebb1dc100487ee11aba2e06f5a696ed85edcf76afc04f461d0f0b"
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
