class DevrecallCli < Formula
  desc "On-device developer activity aggregator (CLI only)"
  homepage "https://devrecall.dev"
  version "0.1.32"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/pavelpilyak/devrecall/releases/download/v#{version}/devrecall-darwin-aarch64.tar.gz"
      sha256 "f0e842017ffe6af58c43c7977b48507453273fe0a5ab77a6c827da083e223c08"
    end
    on_intel do
      url "https://github.com/pavelpilyak/devrecall/releases/download/v#{version}/devrecall-darwin-x86_64.tar.gz"
      sha256 "fa358abad8f1475e0084b34ab6782b70a3f39ab6dfe0e1e91ca5ff307f9f9367"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/pavelpilyak/devrecall/releases/download/v#{version}/devrecall-linux-aarch64.tar.gz"
      sha256 "b9bb484f4d0833701c11d03812ef9faeb59bfe5f8de05f54e384d1b94864d917"
    end
    on_intel do
      url "https://github.com/pavelpilyak/devrecall/releases/download/v#{version}/devrecall-linux-x86_64.tar.gz"
      sha256 "d3e1f3eb866fa6cfa2f0d122d8ec7a081f507e4789d6c7e951bbd63daa33f787"
    end
  end

  def install
    arch_suffix = if OS.mac? && Hardware::CPU.arm?
                    "darwin-aarch64"
                  elsif OS.mac?
                    "darwin-x86_64"
                  elsif Hardware::CPU.arm?
                    "linux-aarch64"
                  else
                    "linux-x86_64"
                  end
    bin.install "devrecall-#{arch_suffix}" => "devrecall"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/devrecall --version")
  end
end
