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
    let animateDuration:NSTimeInterval = 0.2
    
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
        fixCloseButtonFrame(tag)
        
        moveCloseButton(delay, deltaY: height)
    }
    
    func fixCloseButtonFrame(tag:CGFloat) {
        
        var frame = self.closeButton.layer.frame
        let x:CGFloat = frame.width * tag
        frame.origin.x = x
        self.closeButton.layer.frame = frame
    }
    
    func moveCloseButton(delay:NSTimeInterval, deltaY:CGFloat) {
        
        moveIcon(self.closeButton, duration: animateDuration, delay: delay, deltaY: deltaY) { () -> () in
            UIView.addKeyframeWithRelativeStartTime(self.animateDuration/2, relativeDuration: self.animateDuration/2, animations: { () -> Void in
                self.closeButton.alpha = deltaY>0 ? 1:0
                self.layoutIfNeeded()
            })
        }
        
    }
    
    func dropIcon(button:UIButton, delay:NSTimeInterval) {
        moveIcon(button, delay: delay, deltaY: self.bounds.height)
    }
    
    func moveIcon(let button:UIButton, let delay:NSTimeInterval, let  deltaY:CGFloat) {
        moveIcon(button, duration: animateDuration/2, delay: delay, deltaY: deltaY, nil)
    }
    
    func moveIcon(let button:UIButton, let duration:NSTimeInterval,let delay:NSTimeInterval, let  deltaY:CGFloat, completion:(()->())?) {
        button.userInteractionEnabled = false
        
        UIView.animateKeyframesWithDuration(duration, delay: delay, options: UIViewKeyframeAnimationOptions.CalculationModeCubic, animations: { () -> Void in
            
            UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: duration, animations: { () -> Void in
                self.moveViewTo(button, deltaY:deltaY)
                self.layoutIfNeeded()
            })
            
            completion?()
            
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
