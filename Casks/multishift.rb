cask "multishift" do
  version "0.3.0,4"
  sha256 "ec904e2d2ecf390a580a1633838c6378122b0d1f2d1c46b23587bcd986a2482b"

  url "https://sokolovmo.ru/multishift/MultiShift-#{version.csv.first}-#{version.csv.second}-arm64.zip"
  name "MultiShift"
  desc "File conversion and tools for Finder"
  homepage "https://sokolovmo.ru/multishift/"

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: ">= :sonoma"

  app "MultiShift.app"

  postflight do
    if ENV["MULTI_APPS_ALLOW_UNNOTARIZED"] == "1"
      system_command "/usr/bin/codesign",
                     args: ["--verify", "--deep", "--strict", "#{appdir}/MultiShift.app"],
                     must_succeed: true
      system_command "/usr/bin/xattr",
                     args: ["-dr", "com.apple.quarantine", "#{appdir}/MultiShift.app"],
                     must_succeed: true
    end
  end

  caveats <<~EOS
    This app is not notarized by Apple. To install without quarantine, explicitly use:
      MULTI_APPS_ALLOW_UNNOTARIZED=1 brew install --cask SokolovMO/apps/multishift
    Updates are available inside the app and require confirmation.
    Quit the app after current work finishes before a Homebrew upgrade.
    Uninstalling this cask preserves your settings and history.
  EOS
end
