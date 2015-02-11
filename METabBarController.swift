//
//  TabBarController.swift
//  tabBar
//
//  Created by Artwalk on 2/3/15.
//  Copyright (c) 2015 Artwalk. All rights reserved.
//

import UIKit

@IBDesignable class TabBarController: UITabBarController {
    
    let fakeTabBarView = MEBottomBarView.instanceMEBottomBarView()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.tabBar.addSubview(fakeTabBarView)
    }
    
    override func viewWillLayoutSubviews() {
        
        var frame = self.tabBar.frame
        
        frame.size.height = 65
        frame.origin.y = self.view.frame.size.height - 65
        
        self.tabBar.frame = frame
        
        (frame.origin.x, frame.origin.y ) = (0, 0)
        
        fakeTabBarView.frame = frame
        
        fakeTabBarView.layer.masksToBounds = true
    }
    
    func hidden() {
        moveWithAnimation(tabBar: self.tabBar, height: -self.tabBar.bounds.height)
    }
    
    func show() {
        moveWithAnimation(tabBar: self.tabBar, height: self.tabBar.bounds.height)
    }
    
    func moveWithAnimation(#tabBar:UITabBar, height:CGFloat) {
        UIView.animateWithDuration(1, animations: { () -> Void in
            self.moveViewTo(tabBar, deltaY: height)
        })
    }
    
    func moveViewTo(view:UIView, deltaY:CGFloat) {
        var bounds = view.bounds
        bounds.origin.y = deltaY
        view.bounds = bounds
    }
}