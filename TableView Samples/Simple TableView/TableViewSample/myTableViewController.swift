//
//  myTableViewController.swift
//  TableViewSample
//
//  Created by Jigar M on 31/07/14.
//  Copyright (c) 2014 Jigar M. All rights reserved.
//

import UIKit

class myTableViewController: UITableViewController {
    var myData:Array<AnyObject> = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myData = ["Apple", "Banana", "Carrot", "Cherry", "Mango", "Melon", "Orange", "Pear", "Pineapple", "Pulms", "Peaches", "Strawberry"];
        
    }

    // #pragma mark - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        return myData.count
    }

    override func tableView(tableView: UITableView?, cellForRowAtIndexPath indexPath: NSIndexPath?) -> UITableViewCell? {
        //let cell = tableView?.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        let CellID : String = "Cell";
        var cell:UITableViewCell = tableView?.dequeueReusableCellWithIdentifier(CellID) as UITableViewCell
        if let ip = indexPath {
            cell.textLabel.text = myData[ip.row] as String
        }
        
        return cell
    }

    override func tableView(tableView: UITableView!, didDeselectRowAtIndexPath indexPath: NSIndexPath!) {
        //println("You selected cell \(indexPath.row)!")
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView?, canEditRowAtIndexPath indexPath: NSIndexPath?) -> Bool {
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView?, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath?) {
        if editingStyle == .Delete {
            if let tv = tableView {
                myData.removeAtIndex(indexPath!.row)
                tv.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
            }
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
}
