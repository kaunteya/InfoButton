//
//  InfoButton.swift
//  InfoButton
//
//  Created by Kauntey Suryawanshi on 25/06/15.
//  Copyright (c) 2015 Kauntey Suryawanshi. All rights reserved.
//

import Foundation
import Cocoa

@IBDesignable
class InfoButton : NSControl {
    var mainSize: CGFloat!
    @IBInspectable var filledMode: Bool = true
    @IBInspectable var contentString: String = ""
    @IBInspectable var primaryColor: NSColor = NSColor.scrollBarColor()
    @IBInspectable var secondaryColor: NSColor = NSColor.whiteColor()
    var trackingArea: NSTrackingArea!
    var mouseInside = false {
        didSet {
            self.needsDisplay = true
        }
    }
    
    override func updateTrackingAreas() {
        super.updateTrackingAreas()
        if trackingArea != nil {
            self.removeTrackingArea(trackingArea)
        }
        trackingArea = NSTrackingArea(rect: self.bounds, options: NSTrackingAreaOptions.MouseEnteredAndExited | NSTrackingAreaOptions.ActiveAlways, owner: self, userInfo: nil)
        self.addTrackingArea(trackingArea)
    }
    
    private var stringAttributeDict = [NSObject: AnyObject]()
    private var circlePath: NSBezierPath!
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        let frameSize = self.frame.size
        if frameSize.width != frameSize.height {
            self.frame.size.height = self.frame.size.width
        }
        self.mainSize = self.frame.size.height
        stringAttributeDict[NSFontAttributeName] = NSFont.systemFontOfSize(mainSize * 0.6)
        
        let inSet: CGFloat = 2
        let rect = NSMakeRect(inSet, inSet, mainSize - inSet * 2, mainSize - inSet * 2)
        circlePath = NSBezierPath(ovalInRect: rect)
    }
    
    
    override func drawRect(dirtyRect: NSRect) {
        if filledMode {
            (mouseInside ? primaryColor : primaryColor.colorWithAlphaComponent(0.35)).setFill()
            circlePath.fill()
            stringAttributeDict[NSForegroundColorAttributeName] = secondaryColor
        } else {
            (mouseInside ? primaryColor : primaryColor.colorWithAlphaComponent(0.35)).setStroke()
            circlePath.stroke()
            stringAttributeDict[NSForegroundColorAttributeName] = (mouseInside ? primaryColor : primaryColor.colorWithAlphaComponent(0.35))
        }
        
        var attributedString = NSAttributedString(string: "?", attributes: stringAttributeDict)
        var stringLocation = NSMakePoint(mainSize / 2 - attributedString.size.width / 2, mainSize / 2 - attributedString.size.height / 2)
        attributedString.drawAtPoint(stringLocation)
    }
    
    override func mouseDown(theEvent: NSEvent) {
        println("Show popover")
        showPopoverWithText(self.contentString)

    }
    override func mouseEntered(theEvent: NSEvent) { mouseInside = true }
    override func mouseExited(theEvent: NSEvent) { mouseInside = false }
    
    func showPopoverWithText(text: String) {
        var textField = makeTextField(text)
        var popover = makePopover(textField)
        popover.showRelativeToRect(self.frame, ofView: self.superview!, preferredEdge: NSMaxXEdge)
        
    }

    private let popoverMargin = CGFloat(20)
    func makePopover(textField: NSTextField) ->NSPopover {
        var popover = NSPopover()
        popover.behavior = NSPopoverBehavior.Transient
        popover.animates = false
        popover.contentViewController = NSViewController()
        popover.contentViewController!.view = NSView(frame: NSZeroRect)
        popover.contentViewController!.view.addSubview(textField)
        popover.contentViewController!.view.wantsLayer = true
        var viewSize = textField.frame.size; viewSize.width += (popoverMargin * 2); viewSize.height += (popoverMargin * 2)
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
        textField.setFrameOrigin(NSMakePoint(popoverMargin, popoverMargin))
        return textField
    }
}

//NSMinXEdge NSMinYEdge NSMaxXEdge NSMaxYEdge