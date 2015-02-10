//
//  TabBarController.swift
//  tabBar
//
//  Created by Artwalk on 2/3/15.
//  Copyright (c) 2015 Artwalk. All rights reserved.
//

import UIKit

@IBDesignable class TabBarController: UITabBarController {
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        hidden()
    }
    
    
    let fakeTabBarView = MEBottomBarView.instanceMEBottomBarView()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.tabBar.addSubview(fakeTabBarView)
    }
    
    override func viewWillLayoutSubviews() {
        
        var frame = self.tabBar.frame
        
        frame.size.height = 56
        frame.origin.y = self.view.frame.size.height - 56
        
        self.tabBar.frame = frame
        
        (frame.origin.x, frame.origin.y ) = (0, 0)
        
        fakeTabBarView.frame = frame
    }
    
    func hidden() {
        UIView.animateWithDuration(1, animations: { () -> Void in
            
            moveViewTo(self.tabBar, -self.tabBar.bounds.height)
        })
//        self.tabBar
    }
    
}

func moveViewTo(view:UIView, deltaY:CGFloat) {
    var bounds = view.bounds
    bounds.origin.y = deltaY
    view.bounds = bounds
}