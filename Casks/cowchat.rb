cask "cowchat" do
  version "0.9.16"
  sha256 "be93be02a5127922756668146b1a9a547f45a32efee1e7a37aca43b379d11c56"

  url "https://github.com/cowboyinc/cowchat/releases/download/v0.9.16/Cowchat-#{version}.dmg"
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
