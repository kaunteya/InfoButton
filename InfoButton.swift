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
    
    @IBInspectable var showOnHover: Bool = false
    @IBInspectable var fillMode: Bool = true
    @IBInspectable var animatePopover: Bool = false
    @IBInspectable var content: String = ""
    @IBInspectable var primaryColor: NSColor = NSColor.scrollBarColor
    
    var secondaryColor: NSColor = NSColor.white
    var popover: NSPopover!
    var trackingArea: NSTrackingArea!
    var mainSize: CGFloat!
    
    var mouseInside = false {
        didSet {
            self.needsDisplay = true
            
            if (showOnHover) {
                if (popover == nil) {
                    popover = NSPopover(content: self.content, doesAnimate: self.animatePopover)
                }
                
                if (mouseInside) {
                    popover.show(relativeTo: self.frame, of: self.superview!, preferredEdge: NSRectEdge.maxX)
                }
                else {
                    popover.close()
                }
            }
        }
    }
    
    override public func updateTrackingAreas() {
        super.updateTrackingAreas()
        
        if (trackingArea != nil) {
            self.removeTrackingArea(trackingArea)
        }
        trackingArea = NSTrackingArea(rect: self.bounds, options: [NSTrackingAreaOptions.mouseEnteredAndExited, NSTrackingAreaOptions.activeAlways], owner: self, userInfo: nil)
        self.addTrackingArea(trackingArea)
    }
    
    private var stringAttributeDict = [String: AnyObject]()
    private var circlePath: NSBezierPath!

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        
        let frameSize = self.frame.size
        
        if (frameSize.width != frameSize.height) {
            self.frame.size.height = self.frame.size.width
        }
        
        self.mainSize = self.frame.size.height
        stringAttributeDict[NSFontAttributeName] = NSFont.systemFont(ofSize: mainSize * 0.6)

        let inSet: CGFloat = 2
        let rect = NSMakeRect(inSet, inSet, mainSize - inSet * 2, mainSize - inSet * 2)
        circlePath = NSBezierPath(ovalIn: rect)
    }
    
    override public func draw(_ dirtyRect: NSRect) {
        var activeColor: NSColor =  primaryColor.withAlphaComponent(0.35)
        
        if (mouseInside || (popover != nil && popover!.isShown)) {
            activeColor = primaryColor
        }
        
        if (fillMode) {
            activeColor.setFill()
            circlePath.fill()
            stringAttributeDict[NSForegroundColorAttributeName] = secondaryColor
        }
        else {
            activeColor.setStroke()
            circlePath.stroke()
            stringAttributeDict[NSForegroundColorAttributeName] = activeColor
        }

        let attributedString = NSAttributedString(string: "?", attributes: stringAttributeDict)
        let stringLocation = NSMakePoint(mainSize / 2 - attributedString.size().width / 2, mainSize / 2 - attributedString.size().height / 2)
        attributedString.draw(at: stringLocation)
    }

    override public func mouseDown(with event: NSEvent) {
        
        if (popover == nil) {
            popover = NSPopover(content: self.content, doesAnimate: self.animatePopover)
            popover.delegate = self
        }
        
        if (popover.isShown) {
            popover.close()
        }
        else {
            popover.show(relativeTo: self.frame, of: self.superview!, preferredEdge: NSRectEdge.maxX)
        }
    }
    
    public func popoverDidClose(_ notification: Notification) { self.needsDisplay = true }
    
    override public func mouseEntered(with event: NSEvent) { mouseInside = true }
    override public func mouseExited(with event: NSEvent) { mouseInside = false }

}

//MARK: Extension for making a popover from string
extension NSPopover {

    convenience init(content: String, doesAnimate: Bool) {
        self.init()

        self.behavior = NSPopoverBehavior.transient
        self.animates = doesAnimate
        self.contentViewController = NSViewController()
        self.contentViewController!.view = NSView(frame: NSZeroRect)//remove this ??

        let popoverMargin = CGFloat(20)
        let textField: NSTextField = {
            content in
            
            let textField = NSTextField(frame: NSZeroRect)

            textField.isEditable = false
            textField.stringValue = content
            textField.isBordered = false
            textField.drawsBackground = false
            textField.sizeToFit()
            textField.setFrameOrigin(NSMakePoint(popoverMargin, popoverMargin))
            return textField
            
            }(content)

        self.contentViewController!.view.addSubview(textField)
        var viewSize = textField.frame.size; viewSize.width += (popoverMargin * 2); viewSize.height += (popoverMargin * 2)
        self.contentSize = viewSize
    }
}
