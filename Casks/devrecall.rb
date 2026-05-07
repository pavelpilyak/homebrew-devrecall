cask "devrecall" do
  version "0.1.5"

  on_arm do
    url "https://github.com/pavelpilyak/devrecall/releases/download/v#{version}/DevRecall-aarch64.dmg"
    sha256 "5a3dc893f52a425342f28bebcaf3be1592f10ce8db1111415357c93476d9955f"
  end

  on_intel do
    url "https://github.com/pavelpilyak/devrecall/releases/download/v#{version}/DevRecall-x86_64.dmg"
    sha256 "f90a417517a3b75faf344332306a39a9c4811a9e4b749c46ad7a09f0aba29650"
  end

  name "DevRecall"
  desc "On-device developer activity aggregator — standups, brag docs, and work memory"
  homepage "https://devrecall.dev"

  depends_on macos: ">= :monterey"
  depends_on formula: "pavelpilyak/devrecall/devrecall-cli"

  app "DevRecall.app"

  postflight do
    system_command "#{HOMEBREW_PREFIX}/bin/devrecall",
                   args: ["daemon", "install"]
  end

  uninstall launchctl: "dev.devrecall.agent",
            quit:      "dev.devrecall.app"

  zap trash: "~/.devrecall"
end
