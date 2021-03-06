#!/usr/bin/env bash

# Close open System Preferences panes to prevent them from overriding settings
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until execution has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

# Restart automatically if the computer freezes
sudo systemsetup -setrestartfreeze on

# Disable smart quotes as they're annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable smart dashes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Enable AirDrop over Ethernet and on unsupported Macs running Lion
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

# Setup terminal to use Homebrew theme
defaults write ~/Library/Preferences/com.apple.Terminal.plist "Default Window Settings" "Homebrew"
defaults write ~/Library/Preferences/com.apple.Terminal.plist "Startup Window Settings" "Homebrew"

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Reveal IP address, hostname, OS version, etc. when clicking the clock in the login window
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# Disable press-and-hold for keys (e.g. accented characters) in favour of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Set fastest key repeat and shortest delay until repeat
defaults write NSGlobalDomain KeyRepeat -int 0
#defaults write NSGlobalDomain InitialKeyRepeat -int 12

# Set language and text formats
defaults write NSGlobalDomain AppleLanguages -array "en"
defaults write NSGlobalDomain AppleLocale -string "en_GB@currency=GBP"
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
defaults write NSGlobalDomain AppleMetricUnits -bool true

# Finder: Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: Show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Finder: Show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Automatically open a new Finder window when a volume is mounted
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Empty Trash securely by default
defaults write com.apple.finder EmptyTrashSecurely -bool true

# Show the ~/Library folder
chflags nohidden ~/Library

# Speed up Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.1

# Wipe all (default) app icons from the Dock
# Useful when setting up a new Mac, or if you don't use the Dock to launch apps.
defaults write com.apple.dock persistent-apps -array

# Set the icon size of Dock items to 36 pixels
defaults write com.apple.dock tilesize -int 56

# Show indicator lights for open applications in the Dock
defaults write com.apple.dock show-process-indicators -bool true

# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Show Dock instantly when mouse hits edge of screen
defaults write com.apple.Dock autohide-delay -float 0

# Window focus follows mouse for Terminal and X11 apps
defaults write com.apple.terminal FocusFollowsMouse -bool true
defaults write org.x.X11 wm_ffm -bool true

# Save screenshots to the desktop
# defaults write com.apple.screencapture location -string "$HOME/Desktop"

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
# defaults write com.apple.screencapture type -string "png"

# Disable shadow in screenshots
# defaults write com.apple.screencapture disable-shadow -bool true

# Restart affected apps
for app in "Dock" "Finder" "Terminal"; do
  killall "${app}" &> /dev/null
done

echo "Done OS X configurations. Some changes require a logout/restart to take effect."
