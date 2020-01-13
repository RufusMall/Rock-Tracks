# Rock-Tracks
Rock tracks app. Shows a list of tracks from the apple iTunes API.

Build status:
[![Build Status](https://app.bitrise.io/app/5bc6d2d6fe28459f/status.svg?token=cHCGVD16DFGI0rjszyFKZg&branch=master)](https://app.bitrise.io/app/5bc6d2d6fe28459f)

Trello: https://trello.com/b/oqkSElSp/sp-rock-tracks

Shows a list of rock tracks from: iTunes API.

Unfortunately if I did anymore, I would go further over the 5 hour time limit (I took 5:30).

The trello board includes my list of things remaining todo, I imagine this is not exhaustive

Basic architecture is using MVVM. In this instance I chose to talk from ViewModels->Views via delegation instead of closures.

The build status badge above is created by my CI. It builds the app and runs unit tests.

Built and tested:
-CI xcode 11.2.x on macOS 10.14.6
-xcode Version 11.2.1 (11B500), iOS 13 simulators, and iPhone X physical device
