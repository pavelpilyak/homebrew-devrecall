class DevrecallCli < Formula
  desc "On-device developer activity aggregator (CLI only)"
  homepage "https://devrecall.dev"
  version "0.1.20"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/pavelpilyak/devrecall/releases/download/v#{version}/devrecall-darwin-aarch64.tar.gz"
      sha256 "5b7d0b2897f266b6a4cfe37e5ee036a77750a1e9356afc7f9ad3311d93eadd5c"
    end
    on_intel do
      url "https://github.com/pavelpilyak/devrecall/releases/download/v#{version}/devrecall-darwin-x86_64.tar.gz"
      sha256 "ef1909766dcaaf378a795afcbdda2d07176ef851b01389e669343cd01b0fca49"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/pavelpilyak/devrecall/releases/download/v#{version}/devrecall-linux-aarch64.tar.gz"
      sha256 "a5db7e5edadc38ffe434dab3d1bcb520b3b535fd2b442d07d69ce160c95af6f9"
    end
    on_intel do
      url "https://github.com/pavelpilyak/devrecall/releases/download/v#{version}/devrecall-linux-x86_64.tar.gz"
      sha256 "ee665b85e203735227e863047f940f5ddb9cbfc8b758b3f752f22c5bdef67845"
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
