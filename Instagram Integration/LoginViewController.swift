//
//  LoginViewController.swift
//  Instagram Integration
//
//  Created by Prashant G on 8/3/18.
//  Copyright © 2018 MyOrg. All rights reserved.
//

import UIKit

class LoginViewController: ViewController,UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        signInRequest()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func signInRequest() {
        
        let url = String(format: "%@?client_id=%@&redirect_uri=%@&response_type=token&scope=%@&DEBUG=True", arguments: [INSTAGRAM_IOS.AUTHURL,INSTAGRAM_IOS.CLIENTID,INSTAGRAM_IOS.REDIRECTURL,INSTAGRAM_IOS.SCOPE])
        
        let request = URLRequest.init(url: URL.init(string: url)!)
        
        webView.loadRequest(request)
    }
    
    func checkRequestForCallBackUrl(request:URLRequest) -> Bool {
        
        let URLString = (request.url?.absoluteString)! as String
        
        if URLString.hasPrefix(INSTAGRAM_IOS.REDIRECTURL) {
            let range:Range<String.Index> = URLString.range(of: "#access_token=")!
            getAuthToken(authToken: URLString.substring(from: range.upperBound))
            return false
        }
        
        return true
    }
    
    
    
    func getAuthToken(authToken: String) {
        
        let url = String(format:"https://api.instagram.com/v1/users/self/?access_token=%@",authToken)
        let request:NSMutableURLRequest = NSMutableURLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        let session = URLSession(configuration: URLSessionConfiguration.default)
        session.dataTask(with: request as URLRequest) { (data, response, error ) -> Void in
            
            if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
                let strFullName = (json?.value(forKey: "data")as AnyObject).value(forKey: "full_name") as? String
                
                let alert = UIAlertController(title: "FULL NAME", message: strFullName, preferredStyle: .alert)
                let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: "OK Action"), style: .default, handler:nil)
                alert.addAction(okAction)
                self.present(alert, animated:true)
                    
                }
        }.resume()
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return checkRequestForCallBackUrl(request: request)
    }
    
}
















