cask "devrecall" do
  version "0.1.0"

  on_arm do
    url "https://github.com/pavelpilyak/devrecall/releases/download/v#{version}/DevRecall-aarch64.dmg"
    sha256 "3447d033a64a5d671acb0f935df5fabc916645dd43bddd8507d59cfe8acc8582"
  end

  on_intel do
    url "https://github.com/pavelpilyak/devrecall/releases/download/v#{version}/DevRecall-x86_64.dmg"
    sha256 "6dbe7b7e1673ad03bbd14195f73e1daa9cf562d0c79038eeef0edd2ca94be6c0"
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
