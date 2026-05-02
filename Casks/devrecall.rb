cask "devrecall" do
  version "0.1.2"

  on_arm do
    url "https://github.com/pavelpilyak/devrecall/releases/download/v#{version}/DevRecall-aarch64.dmg"
    sha256 "63410ac14ad0d0dbab214cdc3add1d5c77bae4c9b581593f5f1c96fa7b98eda6"
  end

  on_intel do
    url "https://github.com/pavelpilyak/devrecall/releases/download/v#{version}/DevRecall-x86_64.dmg"
    sha256 "bed19372c2fb19f8e33418f8633f734e8d9e0b0deae0ecef7725d16f4575736a"
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
