class Dot < Formula
  desc "Minimal task tracker for AI agents - like beads, but smaller and faster"
  homepage "https://github.com/joelreymont/dots"
  version "0.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/joelreymont/dots/releases/download/v0.2.0/dot-macos-arm64"
      sha256 "3baeddb14a19c67879926c706938463b79a2aca8442e98c9af5260fc9991f152"
    end
    on_intel do
      odie "Intel Mac binaries not available. Please build from source."
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/joelreymont/dots/releases/download/v0.2.0/dot-linux-x86_64"
      sha256 "32a1a2cafad7c81c8fbac7bcb35b015e58fb45a8cf8a623af290470d97772c3c"
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
