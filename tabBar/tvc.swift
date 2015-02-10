//
//  tvc.swift
//  tabBar
//
//  Created by Artwalk on 2/3/15.
//  Copyright (c) 2015 Artwalk. All rights reserved.
//

import UIKit

class tvc: UITableViewController {

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    override func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell =  UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "reuse")
        
        cell.textLabel?.text = "\(indexPath.row)"
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = UIViewController(nibName: "vc", bundle:nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
