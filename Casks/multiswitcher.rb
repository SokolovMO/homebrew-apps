cask "multiswitcher" do
  version "0.4.5,79"
  sha256 "adacdb5daddde8a4d3b63af6a9641107c6debf2625ec916f61e7dbf3b383325a"

  url "https://sokolovmo.ru/multiswitcher/MultiSwitcher-#{version.csv.first}-#{version.csv.second}-arm64.dmg"
  name "MultiSwitcher"
  desc "Keyboard layout correction"
  homepage "https://sokolovmo.ru/multiswitcher/"

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :sequoia

  app "MultiSwitcher.app"

  if ENV["HOMEBREW_MULTI_APPS_ALLOW_UNNOTARIZED"] == "1"
    postflight_steps do
      run "/usr/bin/codesign", args: ["--verify", "--deep", "--strict", "{{appdir}}/MultiSwitcher.app"]
      run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/MultiSwitcher.app"]
    end
  end

  caveats <<~EOS
    This app is not notarized by Apple. To install without quarantine, explicitly use:
      HOMEBREW_MULTI_APPS_ALLOW_UNNOTARIZED=1 brew install --cask SokolovMO/apps/multiswitcher
    Updates are available inside the app and require confirmation.
    Quit the app after current work finishes before a Homebrew upgrade.
    Uninstalling this cask preserves your settings and history.
  EOS
end
