cask "cowchat" do
  version "0.8.4"
  sha256 "e77ea4da0048aa64aa87e987c09db87f74e8e62d9df57486bf84061eddcf1b65"

  url "https://github.com/cowboyinc/cowchat/releases/download/v0.8.4/Cowchat-#{version}.dmg"
  name "Cowchat"
  desc "Local-first chat for AI agent coordination"
  homepage "https://github.com/cowboyinc/cowchat"

  # The formula of the same name installs the `cowchat` and `cowchat-server`
  # CLIs; this cask installs the app, which carries its own server helper in
  # Contents/Helpers. They coexist — keep both on the same version so a server
  # started from the app and one started from the terminal are the same build.
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
