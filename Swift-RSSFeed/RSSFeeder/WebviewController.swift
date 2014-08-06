//
//  WebviewController.swift
//  RSSFeeder
//
//  Created by Jigar M on 06/08/14.
//  Copyright (c) 2014 Jigar M. All rights reserved.
//

import UIKit

class WebviewController: UIViewController, UIWebViewDelegate {

    @IBOutlet var webview : UIWebView
    @IBOutlet var activity : UIActivityIndicatorView
    var url : String?
    var Headline : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.Headline
    }
    
    override func viewWillAppear(animated: Bool) {
        let requestURL = NSURL(string: self.url)
        let request = NSURLRequest(URL: requestURL)
        self.webview.delegate = self;
        self.webview.loadRequest(request)
        super.viewWillAppear(animated);
    }
    
    func webViewDidStartLoad(_webView: UIWebView){
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true;
        activity.startAnimating();
    }
    
    func webViewDidFinishLoad(_webView: UIWebView!){
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false;
        activity.stopAnimating();
    }
    
    func webView(_webView: UIWebView!,
        shouldStartLoadWithRequest request: NSURLRequest!,
        navigationType _navigationType: UIWebViewNavigationType) -> Bool{
            NSLog("Loading URL :%@",request.URL.absoluteString);
            return true;
    }
    
    func webView(_webView: UIWebView!,
        didFailLoadWithError error: NSError!) {
            NSLog("Failed to load with error :%@",error.debugDescription);
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
