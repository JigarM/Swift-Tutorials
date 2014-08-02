//
//  MyTableViewController.swift
//  SwiftUITableView
//
//  Created by Mobmaxime on 01/08/14.
//  Copyright (c) 2014 Jigar M. All rights reserved.
//

import UIKit
import QuartzCore

class MyTableViewController: UITableViewController {

    var DataList: NSArray = NSArray()
    //var rootLayer:CALayer?
    
    //load JSON From mainBundle
    func loadJSONFile() -> NSArray {
        var filePath = NSBundle.mainBundle().pathForResource("data", ofType: "json")
        var err: NSError
        var jsonData : NSData = NSData.dataWithContentsOfMappedFile(filePath) as NSData
        var json: NSDictionary = NSJSONSerialization.JSONObjectWithData(jsonData as NSData, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
        var results: NSArray = json["List"] as NSArray
        return results
        //self.DataList = results
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.DataList = loadJSONFile()
    }

    // #pragma mark - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        return self.DataList.count
    }

    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        let cell:CustomCell = tableView?.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as CustomCell
        
        var data : NSDictionary = self.DataList[indexPath.row] as NSDictionary
        var Username : String = data.objectForKey("Name") as String
        var screenname : String = data.objectForKey("screenname") as String
        var description : String = data.objectForKey("description") as String
        var dp : String = data.objectForKey("image") as String
        
        /*UIImageView *imageview = [UIImageView alloc] init];
        imageview.layer.cornerRadius = imageview.frame.size.width / 2;
        imageview.layer.borderWidth = 3.0f;
        imageview.layer.borderColor = [UIColor whiteColor].CGColor;
        imageview.clipsToBounds = YES;*/
        
        //GDC
        var queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        dispatch_async(queue, {
            // Configure the cell...
            cell.Username.text = Username
            cell.ScreenName.text = screenname
            cell.Description.text = description
            dispatch_async(dispatch_get_main_queue(), {
                cell.ProfileDP.image = UIImage(named:"j.png")
                var queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
                
                var layer:CALayer = cell.ProfileDP.layer!
                layer.cornerRadius = cell.ProfileDP.frame.size.width / 2
                layer.borderWidth = 3.0
                layer.borderColor = UIColor.grayColor().CGColor
                cell.ProfileDP.clipsToBounds = true
                
                
                /*var layer:CALayer = cell.ProfileDP.layer!
                layer.shadowPath = UIBezierPath(rect: layer.bounds).CGPath
                layer.shouldRasterize = true;
                layer.rasterizationScale = UIScreen.mainScreen().scale
                layer.borderColor = UIColor.whiteColor().CGColor
                layer.borderWidth = 2.0
                layer.shadowColor = UIColor.grayColor().CGColor
                layer.shadowOpacity = 0.4
                layer.shadowOffset = CGSizeMake(1, 3)
                layer.shadowRadius = 1.5
                cell.ProfileDP.clipsToBounds = false*/
                
            })
        })
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView?, canEditRowAtIndexPath indexPath: NSIndexPath?) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView?, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath?) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView?, moveRowAtIndexPath fromIndexPath: NSIndexPath?, toIndexPath: NSIndexPath?) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView?, canMoveRowAtIndexPath indexPath: NSIndexPath?) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
