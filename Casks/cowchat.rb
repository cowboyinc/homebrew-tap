cask "cowchat" do
  version "0.9.2"
  sha256 "48c5c4a1b4fbe4d3ebb7bd9b6621d1df5a6be20c23a8afddd1e50cfe4f1a4199"

  url "https://github.com/cowboyinc/cowchat/releases/download/v0.9.2/Cowchat-#{version}.dmg"
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
