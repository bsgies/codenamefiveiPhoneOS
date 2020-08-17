# LanguageKit

[![CI Status](http://img.shields.io/travis/garyworks/LanguageKit.svg?style=flat)](https://travis-ci.org/garyworks/LanguageKit)
[![Version](https://img.shields.io/cocoapods/v/LanguageKit.svg?style=flat)](http://cocoapods.org/pods/LanguageKit)
[![License](https://img.shields.io/cocoapods/l/LanguageKit.svg?style=flat)](http://cocoapods.org/pods/LanguageKit)
[![Platform](https://img.shields.io/cocoapods/p/LanguageKit.svg?style=flat)](http://cocoapods.org/pods/LanguageKit)

LanguageKit is an iOS library for easy switch between different language. It use a CSV file for easy editing and sharing strings.

**Work-in-progress, may not work as expected.**

## Features
- Strings file based on CSV
- Programmatically or Storyboard
- Auto update when switch between UIViewControllers

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

LanguageKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'LanguageKit'
```


## How it works

### Prepare strings file

You need a string file in CSV format, like the one below.  
A example had included in the example project. (Localizable.csv)

|Key|en|zh-Hant|zh-Hans|ja|
| ------------- |-------------| -----|
|language.name|English|繁體中文|简体中文|日本語|
|button|Button|按鍵|按键|ボタン|

##### Language key
The locale name (en-US/zh-Hant) does not really matter, just for your own reference. You can have anything including two different versions of en-US.

##### Word key
It is recommended to use a key for each string, however it's also possible to translate between strings.




### Setup with strings file

In your AppDelegate:
```swift
	LanguageKit.shared.setup(filename: "Localizable.csv")	//or your own strings file
	LanguageKit.shared.setLanguage(language: "en-US")		//setup language
```

### Get a localized string
To use it:
```swift
	"button".localized
```

### Switch language
```swift
	LanguageKit.shared.setLanguage(language: "ja")
```

LanguageKit will lookup the string you provided and return the translated version.

### Auto translate a string from Storyboard/XIB

If you are using UIViewController or UITableViewController, or inherit from them. a custom IBOutlet -  **languageComponent** is created for you. Just link controls with it and you are good to go.

Supported UIControl:
- UILabel
- UIButton
- UISearchBar (Placeholder)
- UITextField (Placeholder)
- UISegmentControl
- UITabBar
- UINavigationBar's titleItem


## Language System

There are two types of the language system included in the library:

### Runtime Language Switcher (Default)
You can switch langauge on the fly, the 
 

### System Language Switcher (Required restart)
There are numbers of components in a app that is not runtime changeble (e.g.  Default UINavigationController Back button, SafariWebViewController, Permission Dialog etc.)

If you need to localized these, you need to use 
```swift
	LanguageKit.shared.setLanguage(language: "ja", asSystemLanguage: true)
```
This will brings up a dialog to notify an app restart.

## Author

Gary Law, gary@garylaw.me, [@garyworks](https://twitter.com/garyworks)

## License

LanguageKit is available under the MIT license. See the LICENSE file for more info.
