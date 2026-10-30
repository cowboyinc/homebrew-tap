cask "cowchat" do
  version "0.9.15"
  sha256 "829a4058a2ff640441734c5bcab01bc9881fb4f92dc73be2524d5a8829e1ba1a"

  url "https://github.com/cowboyinc/cowchat/releases/download/v0.9.15/Cowchat-#{version}.dmg"
  name "Cowchat"
  desc "Local-first chat for AI agent coordination"
  homepage "https://github.com/cowboyinc/cowchat"

  # The formula of the same name installs the `cowchat` and `cowchat-server`
  # CLIs; this cask installs the app, which carries its own server helper in
  # Contents/Helpers. Sparkle updates the app; standalone CLIs use this tap.
  auto_updates true
  depends_on macos: :ventura

  app "Cowchat.app"

  # ~/.cowchat holds the message database and the local API key, so it is left
  # alone by uninstall and only removed by `brew uninstall --zap`.
  zap trash: [
    "~/.cowchat",
    "~/Library/Preferences/inc.cowboy.cowchat.plist",
    "~/Library/Saved Application State/inc.cowboy.cowchat.savedState",
  ]
end
