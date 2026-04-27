class DevrecallCli < Formula
  desc "On-device developer activity aggregator (CLI only)"
  homepage "https://devrecall.dev"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/pavelpilyak/devrecall/releases/download/v#{version}/devrecall-darwin-aarch64.tar.gz"
      sha256 "a4a499da580674472f3e6b54543246f6298316d55b3c237e562e24b8829a664f"
    end
    on_intel do
      url "https://github.com/pavelpilyak/devrecall/releases/download/v#{version}/devrecall-darwin-x86_64.tar.gz"
      sha256 "76269435404c6581bae173685a0bf97a25842acb986874d3925e721887c9ccad"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/pavelpilyak/devrecall/releases/download/v#{version}/devrecall-linux-aarch64.tar.gz"
      sha256 "10ce89b24a96e15c3760746d1c4a4e7d991bb0a82f9b5f4a643a28fbf586ad49"
    end
    on_intel do
      url "https://github.com/pavelpilyak/devrecall/releases/download/v#{version}/devrecall-linux-x86_64.tar.gz"
      sha256 "55d69b3a1f032273e63c7a5149062c6897f62de010f31d283387e9a47b922667"
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
