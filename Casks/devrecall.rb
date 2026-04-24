cask "devrecall" do
  version "0.1.0"

  on_arm do
    sha256 "PLACEHOLDER_AARCH64_SHA256"
    url "https://github.com/pavelpilyak/devrecall/releases/download/v#{version}/DevRecall-aarch64.dmg"
  end

  on_intel do
    sha256 "PLACEHOLDER_X86_64_SHA256"
    url "https://github.com/pavelpilyak/devrecall/releases/download/v#{version}/DevRecall-x86_64.dmg"
  end

  name "DevRecall"
  desc "On-device developer activity aggregator — standups, brag docs, and work memory"
  homepage "https://devrecall.dev"

  depends_on macos: ">= :monterey"

  app "DevRecall.app"
  binary "DevRecall.app/Contents/Resources/devrecall", target: "devrecall"

  postflight do
    system_command "#{appdir}/DevRecall.app/Contents/Resources/devrecall",
                   args: ["daemon", "install"]
  end

  uninstall launchctl: "dev.devrecall.agent",
            quit:      "dev.devrecall.app"

  zap trash: "~/.devrecall"
end
