cask "devrecall" do
  version "0.1.3"

  on_arm do
    url "https://github.com/pavelpilyak/devrecall/releases/download/v#{version}/DevRecall-aarch64.dmg"
    sha256 "a245a8d601c9be38ce0c128e67cdbaaa777398736afac57a6d5e0879f0c7e492"
  end

  on_intel do
    url "https://github.com/pavelpilyak/devrecall/releases/download/v#{version}/DevRecall-x86_64.dmg"
    sha256 "3819d484fbbaedee1a3d21159dbf33a6c1a4432cf6f3a04dbfcf6bb5b5ef75c5"
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
