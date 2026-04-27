cask "devrecall" do
  version "0.1.0"

  on_arm do
    url "https://github.com/pavelpilyak/devrecall/releases/download/v#{version}/DevRecall-aarch64.dmg"
    sha256 "157054ebd824db6c43cd1b9ed1ac831f4855ec2143247f00ccd70d43c39dce3b"
  end

  on_intel do
    url "https://github.com/pavelpilyak/devrecall/releases/download/v#{version}/DevRecall-x86_64.dmg"
    sha256 "7c1e5d12c3c448d375a83f3c3aed5566d92cba4004acff8fa8812460182df0a3"
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
