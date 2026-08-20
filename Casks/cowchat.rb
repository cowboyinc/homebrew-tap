cask "cowchat" do
  version "0.8.5"
  sha256 "0f5484de1c2444cba777a9330ef331dbe31292e815ff2bc33f654b44fa73c657"

  url "https://github.com/cowboyinc/cowchat/releases/download/v0.8.5/Cowchat-#{version}.dmg"
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
