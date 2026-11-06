cask "multishift" do
  version "0.3.0,4"
  sha256 "ec904e2d2ecf390a580a1633838c6378122b0d1f2d1c46b23587bcd986a2482b"

  url "https://sokolovmo.ru/multishift/MultiShift-#{version.csv.first}-#{version.csv.second}-arm64.zip"
  name "MultiShift"
  desc "File conversion and tools for Finder"
  homepage "https://sokolovmo.ru/multishift/"

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "MultiShift.app"

  postflight_steps do
    run "/bin/sh",
        args: ["-c", <<~SHELL, "multi-apps-quarantine", "{{appdir}}/MultiShift.app"]
          if [ "$MULTI_APPS_ALLOW_UNNOTARIZED" = "1" ]; then
            /usr/bin/codesign --verify --deep --strict "$1" &&
              /usr/bin/xattr -dr com.apple.quarantine "$1"
          fi
        SHELL
  end

  caveats <<~EOS
    This app is not notarized by Apple. To install without quarantine, explicitly use:
      MULTI_APPS_ALLOW_UNNOTARIZED=1 brew install --cask SokolovMO/apps/multishift
    Updates are available inside the app and require confirmation.
    Quit the app after current work finishes before a Homebrew upgrade.
    Uninstalling this cask preserves your settings and history.
  EOS
end
