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
public class InfoButton : NSControl, NSPopoverDelegate {
    var mainSize: CGFloat!
    @IBInspectable var fillMode: Bool = true
    @IBInspectable var content: String = ""
    @IBInspectable var primaryColor: NSColor = NSColor.scrollBarColor()
    var secondaryColor: NSColor = NSColor.whiteColor()

    var mouseInside = false {
        didSet {
            self.needsDisplay = true
        }
    }
    
    var trackingArea: NSTrackingArea!
    override public func updateTrackingAreas() {
        super.updateTrackingAreas()
        if trackingArea != nil {
            self.removeTrackingArea(trackingArea)
        }
        trackingArea = NSTrackingArea(rect: self.bounds, options: [NSTrackingAreaOptions.MouseEnteredAndExited, NSTrackingAreaOptions.ActiveAlways], owner: self, userInfo: nil)
        self.addTrackingArea(trackingArea)
    }
    
    private var stringAttributeDict = [NSObject: AnyObject]()
    private var circlePath: NSBezierPath!

    var popover: NSPopover!

    
    required public init?(coder: NSCoder) {
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
    
    
    override public func drawRect(dirtyRect: NSRect) {
        var activeColor: NSColor!
        if mouseInside || (popover != nil && popover!.shown){
            activeColor = primaryColor
        } else {
            activeColor = primaryColor.colorWithAlphaComponent(0.35)
        }
        
        if fillMode {
            activeColor.setFill()
            circlePath.fill()
            stringAttributeDict[NSForegroundColorAttributeName] = secondaryColor
        } else {
            activeColor.setStroke()
            circlePath.stroke()
            stringAttributeDict[NSForegroundColorAttributeName] = (mouseInside ? primaryColor : primaryColor.colorWithAlphaComponent(0.35))
        }
        
        var attributedString = NSAttributedString(string: "?", attributes: stringAttributeDict)
        var stringLocation = NSMakePoint(mainSize / 2 - attributedString.size.width / 2, mainSize / 2 - attributedString.size.height / 2)
        attributedString.drawAtPoint(stringLocation)
    }
    
    override public func mouseDown(theEvent: NSEvent) {
        if popover == nil {
            popover = NSPopover.makePopoverFor(self.content)
            popover.delegate = self
        }
        popover.showRelativeToRect(self.frame, ofView: self.superview!, preferredEdge: NSRectEdge.MaxX)
    }

    override public func mouseEntered(theEvent: NSEvent) { mouseInside = true }
    override public func mouseExited(theEvent: NSEvent) { mouseInside = false }
    public func popoverDidClose(notification: NSNotification) {
        self.needsDisplay = true
    }

}

//MARK: Extension for making a popover from string
extension NSPopover {
    class func makePopoverFor(button: String) -> NSPopover {
        let popoverMargin = CGFloat(20)
        func makeTextField(content: String) -> NSTextField {
            let textField = NSTextField(frame: NSZeroRect)
            textField.usesSingleLineMode = false
            textField.editable = false
            textField.stringValue = content
            textField.bordered = false
            textField.drawsBackground = false
            textField.sizeToFit()
            textField.setFrameOrigin(NSMakePoint(popoverMargin, popoverMargin))
            return textField
        }
        
        
        let popover = NSPopover()
        popover.behavior = NSPopoverBehavior.Transient
        popover.animates = false
        popover.contentViewController = NSViewController()
        popover.contentViewController!.view = NSView(frame: NSZeroRect)
        
        let textField = makeTextField(button)
        popover.contentViewController!.view.addSubview(textField)
        var viewSize = textField.frame.size; viewSize.width += (popoverMargin * 2); viewSize.height += (popoverMargin * 2)
        popover.contentSize = viewSize
        return popover
    }
}
//NSMinXEdge NSMinYEdge NSMaxXEdge NSMaxYEdge