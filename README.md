# TeaFriend

<p align="center">
  <img src="https://github.com/PhilomathMac/TeaFriend/blob/main/PortfolioImage.png?raw=true" alt="teaFriend screenshot" width="100%"/>
</p> 

## Description
A SwiftUI app to store all the types of tea you own, sort and search your teas, rate your teas, and get tea recommendations for today's tea.

## Skills Practiced

* CoreData
* Decoding JSON
* UserDefaults
* Pre-Fill Data with teas from JSON file if not previously loaded
* Show list of user created tea objects
* Edit a tea object
* FetchRequests


## Future Features / Fixes

* Featured View: Recommend a Tea
* CloudKit
* Registration / sign-in / sign-out flow
* Settings view

## Use Instructions

This app currently pre-populates with a list of teas. If you would like to start this app totally empty, remove lines 51-56 in ListView.

```swift
.onAppear() {
    if !UserDefaults.standard.bool(forKey: "teasImported") {
        importJSONTeas()
        UserDefaults.standard.set(true, forKey: "teasImported")
    }
}
```
