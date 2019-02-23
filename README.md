# InfoButton

[![Cocoapods Compatible](https://img.shields.io/cocoapods/v/InfoButton.svg)](https://img.shields.io/cocoapods/v/InfoButton.svg)
[![Platform](https://img.shields.io/cocoapods/p/InfoButton.svg)](http://cocoadocs.org/docsets/InfoButton)
[![License](https://img.shields.io/cocoapods/l/InfoButton.svg)](http://cocoadocs.org/docsets/InfoButton)

`InfoButton` is simple and lightweight Information Button for Mac OSX implemented in Swift
![Demo](./images/demo.png)

## Features

- Light Mode and Fill Mode
- Animatable Popover
- Show on Hover

## Installation

#### Direct

Drag `InfoButton.swift` to your project. That is it!

#### CocoaPods

To integrate InfoButton into your Xcode project using [CocoaPods](http://cocoapods.org), specify it in your `Podfile`:

```ruby
use_frameworks!

pod 'InfoButton'
```

## Usage

In Interface builder, drag a `Custom View` from Object Library and set `Custom Class` to `InfoButton`

Since InfoButton is `@IBDesignable`, Attribute Inspector gets updated like this.

![Attribute Inspector](./images/attrInsp.png)

Update `Fill Mode`, `Animate Popover`, `Content` and `Primary Color` and there you have InfoButton ready without writing a single line of code.

## Notes

- Make sure the height and width of InfoButton are `equal`
- Press <kbd>⌥ ↩</kbd> for newline in text field of IB.(Option + Return)

## Todo

- RTF Support for Popover content
- Replace `?` in button with `i` in italics (If you have a suggestion please post it in issues)

## License

`InfoButton` is released under the MIT license. See LICENSE for details.
