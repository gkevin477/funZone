//
//  WebViewController.swift
//  funZone
//
//  Created by admin on 6/4/22.
//

import UIKit
import WebKit
class WebViewController: UIViewController {

    let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        
        guard let url = URL(string: "https://google.com") else{
            return
        }
        webView.load(URLRequest(url: url))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    

}
