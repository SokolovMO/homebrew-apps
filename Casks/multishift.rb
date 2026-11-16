cask "multishift" do
  version "0.4.2,14"
  sha256 "9cb9055acbed7b6b27e1feee45813703b954c67ca4a1d16ce0af071fb17cd29d"

  url "https://sokolovmo.ru/multishift/MultiShift-#{version.csv.first}-#{version.csv.second}-arm64.dmg"
  name "MultiShift"
  desc "File conversion and tools for Finder"
  homepage "https://sokolovmo.ru/multishift/"

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "MultiShift.app"

  if ENV["HOMEBREW_MULTI_APPS_ALLOW_UNNOTARIZED"] == "1"
    postflight_steps do
      run "/usr/bin/codesign", args: ["--verify", "--deep", "--strict", "{{appdir}}/MultiShift.app"]
      run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/MultiShift.app"]
    end
  end

  caveats <<~EOS
    This app is not notarized by Apple. To install without quarantine, explicitly use:
      HOMEBREW_MULTI_APPS_ALLOW_UNNOTARIZED=1 brew install --cask SokolovMO/apps/multishift
    Updates are available inside the app and require confirmation.
    Quit the app after current work finishes before a Homebrew upgrade.
    Uninstalling this cask preserves your settings and history.
  EOS
end
