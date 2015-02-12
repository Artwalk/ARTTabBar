//
//  MEBottomBarView.swift
//  tabBar
//
//  Created by Artwalk on 2/4/15.
//  Copyright (c) 2015 Artwalk. All rights reserved.
//

import UIKit

 class MEBottomBarView: UIView {
    
    let height:CGFloat = 65
    let weith:CGFloat = 0
    
    let animateDuration:NSTimeInterval = 0.2
    let middleInterval:NSTimeInterval = 0.1
    let lastInterval:NSTimeInterval = 0.25
    
    @IBOutlet weak var tabListButton: UIButton!
    @IBOutlet weak var cartOrderButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    @IBOutlet weak var closeButton: UIButton!
    var closeButtonX:Int = 0

    var buttons:Array<UIButton> {
        get {
            return [closeButton, tabListButton, cartOrderButton, settingsButton]
        }
    }

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

        switch closeButtonX {
        case 1:
            riseIcons([1, 2 ,3])
        case 2:
            riseIcons([2, 3, 1])
        case 3:
            riseIcons([3, 2, 1])
        default: 0
        }
        
    }
    
    func dropIcons(tag:Int) {
        closeButtonX = tag
        dropCloseButton(CGFloat(tag-1), delay: middleInterval+lastInterval)
        
        switch tag {
        case 1:
            dropIcons([3, 2, 1])
        case 2:
            dropIcons([1, 3, 2])
        case 3:
            dropIcons([1, 2, 3])
        default: 0
        }
        
    }

    func riseIcons(array:Array<Int>) {
        var delay:NSTimeInterval = 0
        for index in array {
            moveIcon(buttons[index], delay: delay, deltaY: -self.bounds.height)
            delay += middleInterval
        }
    }

    func dropIcons(array:Array<Int>) {
        dropIcon(buttons[array[0]], delay: 0)
        dropIcon(buttons[array[1]], delay: middleInterval)
        dropIcon(buttons[array[2]], delay: lastInterval)
    }
    
    func dropCloseButton(let tag:CGFloat, let delay:NSTimeInterval) {
        fixCloseButtonFrame(tag)
        
        moveCloseButton(delay, deltaY: height)
    }
    
    func fixCloseButtonFrame(let tag:CGFloat) {
        
        var frame = self.closeButton.layer.frame
        let x:CGFloat = frame.width * tag
        frame.origin.x = x
        self.closeButton.layer.frame = frame
    }
    
    func moveCloseButton(let delay:NSTimeInterval, let deltaY:CGFloat) {
        
        moveIcon(self.closeButton, duration: animateDuration, delay: delay, deltaY: deltaY) { () -> () in
            UIView.addKeyframeWithRelativeStartTime(self.animateDuration/2, relativeDuration: self.animateDuration/2, animations: { () -> Void in
                self.closeButton.alpha = deltaY>0 ? 1:0
                self.layoutIfNeeded()
            })
        }
        
    }
    
    func dropIcon(let button:UIButton, let delay:NSTimeInterval) {
        moveIcon(button, delay: delay, deltaY: self.bounds.height)
    }
    
    func moveIcon(let button:UIButton, let delay:NSTimeInterval, let  deltaY:CGFloat) {
        moveIcon(button, duration: animateDuration/2, delay: delay, deltaY: deltaY, nil)
    }
    
    func moveIcon(let button:UIButton, let duration:NSTimeInterval,let delay:NSTimeInterval, let  deltaY:CGFloat, completion:(()->())?) {
        button.userInteractionEnabled = false
        
        UIView.animateKeyframesWithDuration(duration, delay: delay, options: UIViewKeyframeAnimationOptions.CalculationModeCubicPaced, animations: { () -> Void in
            
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
