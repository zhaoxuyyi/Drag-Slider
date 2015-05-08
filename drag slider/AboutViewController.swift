//
//  AboutViewController.swift
//  BullsEye
//
//  Created by zhaoxuyi on 15/4/27.
//  Copyright (c) 2015年 zhaoxuyi. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!

    @IBAction func close()
   {
    dismissViewControllerAnimated(true, completion: nil);
   }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if let htmlFile = NSBundle.mainBundle().pathForResource("BullsEye", ofType: "html"){
        let htmlData = NSData(contentsOfFile: htmlFile)
        let baseURL = NSURL.fileURLWithPath(NSBundle.mainBundle().bundlePath)
        webView.loadData(htmlData, MIMEType: "text/html", textEncodingName: "UTF-8", baseURL: baseURL)
        }
    }

}
