cask "devrecall" do
  version "0.1.19"

  on_arm do
    url "https://github.com/pavelpilyak/devrecall/releases/download/v#{version}/DevRecall-aarch64.dmg"
    sha256 "7a62d400418d1b9fc0619ae85b5861e208de0949b6e9fd6e141738e7845913de"
  end

  on_intel do
    url "https://github.com/pavelpilyak/devrecall/releases/download/v#{version}/DevRecall-x86_64.dmg"
    sha256 "d1f0f9b9dbe4757abd831ee9fd3b2ab85e2b93e2565a0021e5f9af7659a6f7e3"
  end

  name "DevRecall"
  desc "On-device developer activity aggregator — standups, brag docs, and work memory"
  homepage "https://devrecall.dev"

  depends_on macos: ">= :monterey"

  app "DevRecall.app"
  binary "#{appdir}/DevRecall.app/Contents/MacOS/devrecall"

  postflight do
    # Kill any running `devrecall serve` so the desktop app respawns under the
    # newly bundled binary on next launch. Without this, the old daemon
    # process keeps serving the previous version's API.
    system_command "/usr/bin/pkill",
                   args:         ["-f", "devrecall serve"],
                   must_succeed: false
    # Invoke the bundled binary directly. Don't trust `#{HOMEBREW_PREFIX}/bin/devrecall`
    # — if a stale devrecall-cli formula is installed, that symlink still
    # points at its old binary, and we'd run the wrong `daemon install`.
    system_command "#{appdir}/DevRecall.app/Contents/MacOS/devrecall",
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
