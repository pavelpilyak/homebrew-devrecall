cask "devrecall" do
  version "0.1.33"

  on_arm do
    url "https://github.com/pavelpilyak/devrecall/releases/download/v#{version}/DevRecall-aarch64.dmg"
    sha256 "42e35d9bfe789d0921d0e56b61dcd99cfafd18fc7fbc694e1478dbf884cba927"
  end

  on_intel do
    url "https://github.com/pavelpilyak/devrecall/releases/download/v#{version}/DevRecall-x86_64.dmg"
    sha256 "bad36fa0862cb7c3d0ed425a3611c1b9b976e4b6a0d737b43dcef48775cdfcb1"
  end

  name "DevRecall"
  desc "On-device developer activity aggregator — standups, brag docs, and work memory"
  homepage "https://devrecall.dev"

  depends_on macos: :monterey

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
