//
//  MEBottomBarView.swift
//  tabBar
//
//  Created by Artwalk on 2/4/15.
//  Copyright (c) 2015 Artwalk. All rights reserved.
//

import UIKit

@IBDesignable class MEBottomBarView: UIView {
    
    let height:CGFloat = 65
    let weith:CGFloat = 0
    
    @IBOutlet weak var tabListButton: UIButton!
    @IBOutlet weak var cartOrderButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    @IBOutlet weak var closeButton: UIButton!
    
    
    override func drawRect(rect: CGRect) {
        self.frame.size.height = height
    }
    
    class func instanceMEBottomBarView() -> MEBottomBarView {
        
        let nibView:NSArray = NSBundle.mainBundle().loadNibNamed("MEBottomBarView", owner: nil, options: nil)
        
        return nibView.firstObject as MEBottomBarView
    }
    
    @IBAction func bottomBarButtonOnClicked(sender: UIButton) {
        
        if sender.tag == 0 {
            riseIcons()
        } else {
            dropIcons(sender.tag)
        }
    }
    
    
    func riseIcons() {
        
        moveCloseButton(0, deltaY: -height)
        
        riseIcon(tabListButton, delay: 0)
        riseIcon(cartOrderButton, delay: 0.1)
        riseIcon(settingsButton, delay: 0.2)
    }
    
    func dropIcons(tag:Int) {
        
        dropCloseButton(CGFloat(tag-1), delay: 0.1+0.25)
        switch tag {
        case 1:
            dropIcon(settingsButton, delay: 0)
            dropIcon(cartOrderButton, delay: 0.1)
            dropIcon(tabListButton, delay: 0.25)
        case 2:
            dropIcon(tabListButton, delay: 0)
            dropIcon(cartOrderButton, delay: 0.25)
            dropIcon(settingsButton, delay: 0.1)
        case 3:
            dropIcon(tabListButton, delay: 0)
            dropIcon(cartOrderButton, delay: 0.1)
            dropIcon(settingsButton, delay: 0.25)
        default: 0
        }
        
    }
    
    func riseIcon(button:UIButton, delay:NSTimeInterval) {
        moveIcon(button, delay: delay, deltaY: -self.bounds.height)
    }
    
    func dropCloseButton(tag:CGFloat, delay:NSTimeInterval) {
        var frame = self.closeButton.layer.frame
        let x:CGFloat = frame.width * tag
        frame.origin.x = x
        self.closeButton.layer.frame = frame
        
        moveCloseButton(delay, deltaY: height)
    }
    
    func dropIcon(button:UIButton, delay:NSTimeInterval) {
        moveIcon(button, delay: delay, deltaY: self.bounds.height)
    }
    
    func moveCloseButton(delay:NSTimeInterval, deltaY:CGFloat) {
        UIView.animateWithDuration(0.1, delay: delay, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.moveViewTo(self.closeButton, deltaY:deltaY)
            self.closeButton.alpha = deltaY>0 ? 1:0
            }) { (finished) -> Void in
                
        }
    }
    
    func moveIcon(button:UIButton, delay:NSTimeInterval, deltaY:CGFloat) {
        button.userInteractionEnabled = false
        
        let duration:NSTimeInterval = 0.2
        
        UIView.animateWithDuration(duration, delay: delay, options:UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.moveViewTo(button, deltaY: deltaY)
            }) { (finished) -> Void in
                button.userInteractionEnabled = true
        }
    }
    
    func moveViewTo(view:UIView, deltaY:CGFloat) {
        var frame = view.frame
        frame.origin.y += deltaY
        view.frame = frame
    }
    
}
