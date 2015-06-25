//
//  ViewController.swift
//  InfoButton
//
//  Created by Kauntey Suryawanshi on 25/06/15.
//  Copyright (c) 2015 Kauntey Suryawanshi. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

@IBDesignable
class MyBut : NSControl {
    var mainSize: CGFloat!
    @IBInspectable var filledColor: Bool = true
    @IBInspectable var primaryColor: NSColor = NSColor.grayColor()
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

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        let frameSize = self.frame.size
        if frameSize.width != frameSize.height {
            self.frame.size.height = self.frame.size.width
        }
        self.mainSize = self.frame.size.height
    }
    
    override func drawRect(dirtyRect: NSRect) {
        var strokeColor = mouseInside ? primaryColor : primaryColor.colorWithAlphaComponent(0.35)

        strokeColor.setStroke()
        strokeColor.setFill()
        let offset: CGFloat = 2
        let rect = NSMakeRect(offset, offset, self.frame.width - offset * 2, self.frame.height - offset * 2)
        var circlePath = NSBezierPath(ovalInRect: rect)
        if filledColor {
            circlePath.fill()
        } else {
            circlePath.stroke()
        }
        
        var stringAttributeDict: [NSObject: AnyObject] = [
            NSFontAttributeName: NSFont.systemFontOfSize(mainSize * 0.6),
            NSForegroundColorAttributeName: filledColor ? NSColor.whiteColor() : strokeColor
        ]

        var attributeString = NSAttributedString(string: "?", attributes: stringAttributeDict)
        var stringLocation = NSMakePoint(mainSize / 2 - attributeString.size.width / 2, mainSize / 2 - attributeString.size.height / 2)
        attributeString.drawAtPoint(stringLocation)
    }
    
    override func mouseEntered(theEvent: NSEvent) {
        mouseInside = true
    }
    override func mouseExited(theEvent: NSEvent) {
        mouseInside = false
    }
}

