//
//  MyTableViewController.swift
//  SwiftUITableView
//
//  Created by Mobmaxime on 01/08/14.
//  Copyright (c) 2014 Jigar M. All rights reserved.
//

import UIKit
import Foundation
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
        let jsonString = JSONStringify(json)
        //println(jsonString)
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
                
                /*var layer:CALayer = cell.ProfileDP.layer!
                layer.cornerRadius = cell.ProfileDP.frame.size.width / 2
                layer.borderWidth = 3.0
                layer.borderColor = UIColor.grayColor().CGColor
                cell.ProfileDP.clipsToBounds = true*/
                
                
                var layer:CALayer = cell.ProfileDP.layer!
                layer.shadowPath = UIBezierPath(rect: layer.bounds).CGPath
                layer.shouldRasterize = true;
                layer.rasterizationScale = UIScreen.mainScreen().scale
                layer.borderColor = UIColor.whiteColor().CGColor
                layer.borderWidth = 2.0
                layer.shadowColor = UIColor.grayColor().CGColor
                layer.shadowOpacity = 0.4
                layer.shadowOffset = CGSizeMake(1, 3)
                layer.shadowRadius = 1.5
                cell.ProfileDP.clipsToBounds = false
                
            })
        })
        return cell
    }

    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        if (segue!.identifier == "Detail") {
            var tweet = self.DataList[tableView.indexPathForSelectedRow().row] as NSDictionary
            let DetailVC = segue!.destinationViewController as  DetailViewController
            DetailVC.Dict = tweet
            
            /*let tweet = DataList[tableView.indexPathForSelectedRow().row] as NSDictionary
            let DetailVC = segue!.destinationViewController as  DetailViewController
            DetailVC.ProfileBannerImage = tweet["ProfileBanner"] as UIImageView
            DetailVC.ProfileDPImage = tweet["image"] as UIImageView
            DetailVC.Username = tweet["Name"] as UILabel*/
            
            /*(segue!.destinationViewController.ProfileBannerImage! as UIImageView).image = tweet["ProfileBanner"] as UIImage
            (segue.destinationViewController.ProfileDPImage as UIImageView).image = tweet["image"] as UIImage
            (segue.destinationViewController.Username as UILabel).text = tweet["Name"].description
            (segue.destinationViewController.Screenname as UILabel).text = tweet["screenname"].description*/
        }
    }
    
    func JSONStringify(jsonObj: AnyObject) -> String {
        var e: NSError?
        let jsonData = NSJSONSerialization.dataWithJSONObject(
            jsonObj,
            options: NSJSONWritingOptions(0),
            error: &e)
        if e {
            return ""
        } else {
            return NSString(data: jsonData, encoding: NSUTF8StringEncoding)
        }
    }
}
