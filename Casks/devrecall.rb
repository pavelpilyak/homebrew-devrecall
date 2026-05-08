cask "devrecall" do
  version "0.1.6"

  on_arm do
    url "https://github.com/pavelpilyak/devrecall/releases/download/v#{version}/DevRecall-aarch64.dmg"
    sha256 "3748ca7222e370a16a4269d326e4927940d1df168bdcb35f840a7afe0cec98b9"
    binary "#{appdir}/DevRecall.app/Contents/MacOS/devrecall-aarch64-apple-darwin",
           target: "devrecall"
  end

  on_intel do
    url "https://github.com/pavelpilyak/devrecall/releases/download/v#{version}/DevRecall-x86_64.dmg"
    sha256 "d5c0ccc8b126c8f3f5678d5ae3d69bf1d27c813023adccc78d12192ccfe1402d"
    binary "#{appdir}/DevRecall.app/Contents/MacOS/devrecall-x86_64-apple-darwin",
           target: "devrecall"
  end

  name "DevRecall"
  desc "On-device developer activity aggregator — standups, brag docs, and work memory"
  homepage "https://devrecall.dev"

  depends_on macos: ">= :monterey"

  app "DevRecall.app"

  postflight do
    system_command "#{HOMEBREW_PREFIX}/bin/devrecall",
                   args: ["daemon", "install"]
  end

  uninstall launchctl: "dev.devrecall.agent",
            quit:      "dev.devrecall.app"

  zap trash: "~/.devrecall"

  caveats <<~EOS
    The `devrecall` CLI is bundled inside DevRecall.app and symlinked into
    Homebrew's bin. If you previously installed the standalone CLI formula,
    remove it so its symlink doesn't shadow the bundled one:

      brew uninstall pavelpilyak/devrecall/devrecall-cli

    A single `brew upgrade devrecall` now upgrades both the GUI and CLI.
  EOS
end
