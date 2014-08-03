//
//  DetailViewController.swift
//  SwiftUITableView
//
//  Created by Mobmaxime on 03/08/14.
//  Copyright (c) 2014 Jigar M. All rights reserved.
//

import UIKit
import QuartzCore

class DetailViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var ProfileBannerImage : UIImageView
    @IBOutlet var ProfileDPImage : UIImageView
    @IBOutlet var Username : UILabel
    @IBOutlet var Screenname : UILabel
    @IBOutlet var MyTableview : UITableView
    var Dict : AnyObject  = []
    var list = Array<AnyObject>()
    //var d : AnyObject
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println(Dict)
        
        let d = Dict as NSDictionary
        let pb = d["ProfileBanner"] as String
        ProfileBannerImage.image = UIImage(named:pb)
        ProfileDPImage.image = UIImage(named:d["image"] as String)
        Username.text = d["Name"] as String
        Screenname.text = d["screenname"] as String
        
        self.title = d["Name"] as String
        list = d["recent"] as Array
        
        //println(list.count)
        
        var layer:CALayer = ProfileDPImage.layer!
        layer.shadowPath = UIBezierPath(rect: layer.bounds).CGPath
        layer.shouldRasterize = true;
        layer.rasterizationScale = UIScreen.mainScreen().scale
        layer.borderColor = UIColor.whiteColor().CGColor
        layer.borderWidth = 2.0
        layer.shadowColor = UIColor.grayColor().CGColor
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSizeMake(1, 3)
        layer.shadowRadius = 1.5
        ProfileDPImage.clipsToBounds = false
        
        
        //Tableview Datasource & Delegates
        self.MyTableview.dataSource = self
        self.MyTableview.delegate = self
    }

    // #pragma mark - Table view data source
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return 107
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell {
        let cell:DetailTableViewCell = tableView?.dequeueReusableCellWithIdentifier("DetailCell", forIndexPath: indexPath) as DetailTableViewCell
        
        var data : NSDictionary = self.list[indexPath.row] as NSDictionary
        var Username : String = data.objectForKey("Name") as String
        var description : String = data.objectForKey("description") as String
        var dp : String = data.objectForKey("image") as String
        
        
        /*
            Time & Date Formatting
        */
        let date = NSDate.date(); // "Jul 23, 2014, 11:01 AM" <-- looks local without seconds. But:
        var formatter = NSDateFormatter();
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ";
        let defaultTimeZoneStr = formatter.stringFromDate(date);// "2014-07-23 11:01:35 -0700" <-- same date, local, but with seconds
        formatter.timeZone = NSTimeZone(abbreviation: "UTC");
        let utcTimeZoneStr = formatter.stringFromDate(date);// "2014-07-23 18:01:41 +0000" <-- same date, now in UTC
        
        
        cell.Username.text = Username
        cell.Timestamp.text = defaultTimeZoneStr
        cell.Recent.text = description
        cell.ProfileDP.image = UIImage(named:dp)
        
        return cell
    }

    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
