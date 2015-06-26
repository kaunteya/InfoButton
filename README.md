#InfoButton

`InfoButton` is simple and lightweight Information Button for Mac OSX implemented in Swift
![](./images/demo.png)

##Features
- Easy to Use
- Light Mode and Fill Mode
- Simple and lightweight

##Requirements
- Mac OS X 10.9
- Xcode 6

##Usage
####Initial Steps
1. Drag `InfoButton.swift` to your project.
2. In Interface builder, drag a `Custom View` from Object Library.
3. Set Custom Class to `InfoButton`

####Configuration
Since `InfoButton` is `@IBDesignable`, Attribute Inspector gets updated like this.

![](./images/attrInsp.png)

Update `Fill Mode`, `Content` and `Primary Color` and there you have InfoButton ready without writing a single line of code.

##Notes
- Make sure the height and width of InfoButton are equal
- Press ⌥ ↩ for newline in text field of IB.(Option + Return)

##Todo
- RTF Support for Popover content
