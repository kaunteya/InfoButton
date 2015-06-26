#InfoButton

`InfoButton` is simple and lightweight Information Button for Mac OSX implemented in Swift
![](./images/demo.png)

##Features
- Completely design from Interface builder
- Light Mode and Filled Mode
- Simple and lightweight

##Requirements
- Mac OS X 10.10+
- Xcode 6.3

##Usage
####Initial Steps
1. Drag `InfoButton.swift` to your project.
2. In Interface builder, drag a Custom View from Object Library.
3. Set Custom Class to InfoButton

####Configuration
Since class is `@IBDesignable`, Attribute Inspector gets updated like this.

![](./images/attrInsp.png)

Update `Filled Mode`, `Content String` and `Primary Color` and there you have Info Button ready without writing a single line of code.

##Notes
- Make sure that height and width of InfoButton are equal
- Press ⌥ ↩ for newline in text field of IB.(Option + Return)

##Todo
- RTF Support for Popover content