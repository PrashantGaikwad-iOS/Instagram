//
//  ViewController.swift
//  Instagram Integration
//
//  Created by Prashant G on 8/3/18.
//  Copyright © 2018 MyOrg. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func shareOnInsta(_ sender: Any) {
        InstagramManager.sharedManager.postImageToInstagramWithCaption(imageInstagram:UIImage(named:"fish.png")!, instagramCaption: "Posting image to instagram", view: self.view)

    }
    
}

