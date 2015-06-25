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
    @IBInspectable var filledMode: Bool = true
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

    var stringAttributeDict = [NSObject: AnyObject]()
    var circlePath: NSBezierPath!
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
    
    override func mouseEntered(theEvent: NSEvent) {
        mouseInside = true
    }
    override func mouseExited(theEvent: NSEvent) {
        mouseInside = false
    }
}

