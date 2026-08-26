class DevrecallCli < Formula
  desc "On-device developer activity aggregator (CLI only)"
  homepage "https://devrecall.dev"
  version "0.1.30"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/pavelpilyak/devrecall/releases/download/v#{version}/devrecall-darwin-aarch64.tar.gz"
      sha256 "4ea38f9fac9138b82df728ce2f42e0b8f46ae7ce7112738d1a1b40363816df31"
    end
    on_intel do
      url "https://github.com/pavelpilyak/devrecall/releases/download/v#{version}/devrecall-darwin-x86_64.tar.gz"
      sha256 "de50b23aa4a7df546b84e86ca1ad9370bc926dd016f94ca2383aad874abce594"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/pavelpilyak/devrecall/releases/download/v#{version}/devrecall-linux-aarch64.tar.gz"
      sha256 "7fcfd42b87f34a681bf6457cf70c96c5537c8d90ca675bd4d5d32f77ea5f253b"
    end
    on_intel do
      url "https://github.com/pavelpilyak/devrecall/releases/download/v#{version}/devrecall-linux-x86_64.tar.gz"
      sha256 "e9ea23d723c23a9eaec767ecf624481181c7f6389ae703458513cabb59243a34"
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
