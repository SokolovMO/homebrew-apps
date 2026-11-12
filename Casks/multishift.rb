cask "multishift" do
  version "0.4.0,10"
  sha256 "39a54fe78a292bef12c4cd934581254638a36a671732a464baac58a3e52aa16a"

  url "https://sokolovmo.ru/multishift/MultiShift-#{version.csv.first}-#{version.csv.second}-arm64.zip"
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
