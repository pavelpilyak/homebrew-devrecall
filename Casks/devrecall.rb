cask "devrecall" do
  version "0.1.0"

  on_arm do
    sha256 "506ed26309243b5a309510206e5196f99beb30e1976340073fff53c238666066"
    url "https://github.com/pavelpilyak/devrecall/releases/download/v#{version}/DevRecall_#{version}_aarch64.dmg"
  end

  on_intel do
    sha256 "28bfc16bd24e146a790bcc38ca74347a43933373ae4413effe3a41042f35c0bc"
    url "https://github.com/pavelpilyak/devrecall/releases/download/v#{version}/DevRecall_#{version}_x64.dmg"
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
