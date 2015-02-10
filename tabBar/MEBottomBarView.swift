//
//  MEBottomBarView.swift
//  tabBar
//
//  Created by Artwalk on 2/4/15.
//  Copyright (c) 2015 Artwalk. All rights reserved.
//

import UIKit

class MEBottomBarView: UIView {
    
    @IBOutlet weak var tabListButton: UIButton!
    @IBOutlet weak var cartOrderButton: UIButton!
    @IBOutlet weak var settings: UIButton!
    
    
    let tabListIcon = UIImageView(image: UIImage(named: "TabListIcon"))
    
    override func drawRect(rect: CGRect) {
        
        tabListButton.addSubview(tabListIcon)
    }
    
    class func instanceMEBottomBarView() -> MEBottomBarView {
        
        let nibView:NSArray = NSBundle.mainBundle().loadNibNamed("MEBottomBarView", owner: nil, options: nil)
        
        return nibView.firstObject as MEBottomBarView
    }

    @IBAction func bottomBarButtonOnClicked(sender: UIButton) {
        dropIcons()
        
        switch sender.tag {
//        case 0:
//        case 1:
//        case 2:
        default: 1
        }
    }
    
    func dropIcons() {
        
        UIView.animateWithDuration(0.2, delay: 0, options:UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                self.tabListIcon.alpha = 0
            })
            self.moveViewTo(self.tabListIcon, deltaY: -self.tabListButton.bounds.height)
        }) { (finished) -> Void in
            
        }
        
        UIView.animateWithDuration(0.2, delay: 0.1, options:UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
            
            }) { (finished) -> Void in
                
        }
        
        UIView.animateWithDuration(0.2, delay: 0.25, options:UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
            
            }) { (finished) -> Void in
                
        }
        
        tabListButton.imageView
    }
    
    func moveViewTo(view:UIView, deltaY:CGFloat) {
        var bounds = view.bounds
        bounds.origin.y = deltaY
        view.bounds = bounds
    }
    
}
