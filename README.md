# ISS POSITION/ISS LOCALIZER

ISS LOCALIZER is an open source app for tracking ISS on map. It uses Mapbox SDK for representing current position on map. Position is updating every 5 seconds and it's represented by pin on map. By clicking on that pin you can show annotation with list of current astronauts residing on ISS.

![](https://github.com/ugryzjablko/iss-position/blob/master/ISS%20Position/ISS%20Position/Assets.xcassets/AppIcon.appiconset/app_store.png)

## Tools & requirements

* Xcode 9 with iOS 10.0+ SDK
* CocoaPods

## Configuration

All you have to do to build & run ISS LOCALIZER is to follow 4 simple steps:

1. Clone project `git clone https://github.com/ugryzjablko/iss-position.git`.
2. Create account at https://www.mapbox.com/signup/ and get your own access token, for demo purpouse this repo contains my own access token, be my guest and use it. If you wish to change it, go to Info.plist and update value for MGLMapboxAccessToken key.
3. Using Terminal navigate to 'iss-position' directory and run `pod install` to install required dependencies.
4. Build & Run. Have fun!

## Author
* [Marcin Kuświk]
