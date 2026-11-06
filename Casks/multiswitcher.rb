cask "multiswitcher" do
  version "0.4.0,70"
  sha256 "a407998a704a0d0cc13e3483af2b02c6706b39ef148e883330ca1c6639832baf"

  url "https://sokolovmo.ru/multiswitcher/MultiSwitcher-#{version.csv.first}-#{version.csv.second}-arm64.zip"
  name "MultiSwitcher"
  desc "Keyboard layout correction"
  homepage "https://sokolovmo.ru/multiswitcher/"

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: ">= :sequoia"

  app "MultiSwitcher.app"

  postflight do
    if ENV["MULTI_APPS_ALLOW_UNNOTARIZED"] == "1"
      system_command "/usr/bin/codesign",
                     args: ["--verify", "--deep", "--strict", "#{appdir}/MultiSwitcher.app"],
                     must_succeed: true
      system_command "/usr/bin/xattr",
                     args: ["-dr", "com.apple.quarantine", "#{appdir}/MultiSwitcher.app"],
                     must_succeed: true
    end
  end

  caveats <<~EOS
    This app is not notarized by Apple. To install without quarantine, explicitly use:
      MULTI_APPS_ALLOW_UNNOTARIZED=1 brew install --cask SokolovMO/apps/multiswitcher
    Updates are available inside the app and require confirmation.
    Quit the app after current work finishes before a Homebrew upgrade.
    Uninstalling this cask preserves your settings and history.
  EOS
end
