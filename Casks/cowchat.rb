cask "cowchat" do
  version "0.9.10"
  sha256 "db4f00f0c8aa06eb1b912b66f8d236325da680a6ffa1536a6c7342ba5eb5d6c4"

  url "https://github.com/cowboyinc/cowchat/releases/download/v0.9.10/Cowchat-#{version}.dmg"
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
