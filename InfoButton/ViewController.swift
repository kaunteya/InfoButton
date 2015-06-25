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
    @IBInspectable var filledColor = true
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

//        NSColor.whiteColor().setFill()
//        NSRectFillUsingOperation(dirtyRect, NSCompositingOperation.CompositeSourceOver)
        var strokeColor: NSColor!
        if mouseInside {
            strokeColor = NSColor.redColor()
        } else {
            strokeColor = NSColor.redColor().colorWithAlphaComponent(0.2)
        }
        strokeColor.setStroke()
        strokeColor.setFill()
        let offset: CGFloat = 2
        let rect = NSMakeRect(offset, offset, self.frame.width - offset * 2, self.frame.height - offset * 2)
        var circlePath = NSBezierPath(ovalInRect: rect)
//        circlePath.lineWidth = 2.0
        if filledColor {
            circlePath.fill()
        } else {
            circlePath.stroke()
        }
        var stringAttributes = [NSObject: AnyObject]()
        stringAttributes[NSFontAttributeName] = NSFont.systemFontOfSize(mainSize * 0.6)
        stringAttributes[NSForegroundColorAttributeName] = filledColor ? NSColor.whiteColor() : strokeColor
        var qw = NSMutableAttributedString(string: "q", attributes: stringAttributes)
        var stringPoint: CGPoint = NSMakePoint(mainSize / 2 - qw.size.width / 2, mainSize / 2 - qw.size.height / 2)
        let q: NSString = "?"
        q.drawAtPoint(stringPoint, withAttributes: stringAttributes)
    }
    
    override func mouseEntered(theEvent: NSEvent) {
        mouseInside = true
    }
    override func mouseExited(theEvent: NSEvent) {
        mouseInside = false
    }
}

