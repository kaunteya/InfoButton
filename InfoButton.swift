//
//  InfoButton.swift
//  InfoButton
//
//  Created by Kauntey Suryawanshi on 25/06/15.
//  Copyright (c) 2015 Kauntey Suryawanshi. All rights reserved.
//

import Foundation
import Cocoa

class InfoButton: NSButton {
    let offset = CGFloat(20)

    required init?(coder: NSCoder) {
        super.init(coder: coder)
//        self.bezelStyle = NSBezelStyle.RoundedBezelStyle
        self.imagePosition = NSCellImagePosition.NoImage
        setAttributedString(12, color: NSColor.redColor())
        self.action = "buttonPressed"
        self.target = self
    }

    func setAttributedString(fontSize: CGFloat, color: NSColor) {
        let font = NSFont.labelFontOfSize(fontSize)
        var colorTitle = NSMutableAttributedString(string: "?")
        var titleRange = NSMakeRange(0, colorTitle.length)
        colorTitle.addAttribute(NSForegroundColorAttributeName, value: color, range: titleRange)
        colorTitle.addAttribute(NSFontAttributeName, value: font, range: titleRange)
        self.attributedTitle = colorTitle
    }

    func buttonPressed() {
        println("Button pressed ")
        showPopoverWithText(self.alternateTitle)
    }

    func showPopoverWithText(text: String) {
        var textField = makeTextField(text)
        var popover = makePopover(textField)
        popover.showRelativeToRect(self.frame, ofView: self.superview!, preferredEdge: NSMaxXEdge)
        
    }

    func makePopover(textField: NSTextField) ->NSPopover {
        var popover = NSPopover()
        popover.behavior = NSPopoverBehavior.Transient
        popover.appearance = NSAppearance(appearanceNamed: NSAppearanceNameVibrantLight, bundle: nil)
        popover.animates = false
        popover.contentViewController = NSViewController()
        popover.contentViewController!.view = NSView(frame: NSZeroRect)
        popover.contentViewController!.view.addSubview(textField)
        popover.contentViewController!.view.wantsLayer = true
        var viewSize = textField.frame.size; viewSize.width += (offset * 2); viewSize.height += (offset * 2)
        popover.contentSize = viewSize
        return popover
    }

    func makeTextField(content: String) -> NSTextField {
        var textField = NSTextField(frame: NSZeroRect)
        textField.usesSingleLineMode = false
        textField.editable = false
        textField.stringValue = content
        textField.bordered = false
        textField.drawsBackground = false
        textField.sizeToFit()
        textField.setFrameOrigin(NSMakePoint(offset, offset))
        return textField
    }
}

//NSMinXEdge NSMinYEdge NSMaxXEdge NSMaxYEdge