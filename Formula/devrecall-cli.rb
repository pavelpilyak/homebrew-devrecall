class DevrecallCli < Formula
  desc "On-device developer activity aggregator (CLI only)"
  homepage "https://devrecall.dev"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/pavelpilyak/devrecall/releases/download/v#{version}/devrecall-darwin-aarch64.tar.gz"
      sha256 "298b325005d35165b1d29e9a9c557cdee4f9f4eba2acf81b513989da728e1d9e"
    end
    on_intel do
      url "https://github.com/pavelpilyak/devrecall/releases/download/v#{version}/devrecall-darwin-x86_64.tar.gz"
      sha256 "30af6f3a54f995140df1e3bf1bd841304e62268ce372a4e74326612268434ca1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/pavelpilyak/devrecall/releases/download/v#{version}/devrecall-linux-aarch64.tar.gz"
      sha256 "ea95274a6ae4494ae412151f15327f0df662ef92c4bf219eb09db582bd66b94b"
    end
    on_intel do
      url "https://github.com/pavelpilyak/devrecall/releases/download/v#{version}/devrecall-linux-x86_64.tar.gz"
      sha256 "33e59e2811d584565caca2d35fac9dece95c723b31454ab630e64a5c8bdda4db"
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
