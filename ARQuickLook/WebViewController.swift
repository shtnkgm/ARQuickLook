//
//  WebViewController.swift
//  ARQuickLook
//
//  Created by Shota Nakagami on 2018/07/11.
//  Copyright © 2018年 Shota Nakagami. All rights reserved.
//

import UIKit
import PureLayout
import WebKit

class WebViewController: UIViewController {
    let urlString = "https://developer.apple.com/arkit/gallery/"
    
    lazy var wkWebView: WKWebView = {
        let wkWebView = WKWebView()
        let request = URLRequest(url: URL(string: urlString)!)
        wkWebView.load(request)
        return wkWebView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(wkWebView)
        wkWebView.autoPinEdgesToSuperviewEdges()
    }
}

