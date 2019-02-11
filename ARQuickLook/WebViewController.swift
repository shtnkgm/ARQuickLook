//
//  WebViewController.swift
//  ARQuickLook
//
//  Created by Shota Nakagami on 2018/07/11.
//  Copyright © 2018年 Shota Nakagami. All rights reserved.
//

import UIKit
import WebKit
import SnapKit
import Then

class WebViewController: UIViewController {
    private let urlString = "https://developer.apple.com/arkit/gallery/"
    private var titleObserver: NSKeyValueObservation?
    
    lazy var wkWebView = WKWebView().then {
        let request = URLRequest(url: URL(string: urlString)!)
        $0.load(request)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLayout()
        observeTitle()
    }
    func updateLayout() {
        view.addSubview(wkWebView)
        wkWebView.snp.makeConstraints {
            $0.edges .equalToSuperview()
        }
    }
    
    func observeTitle() {
        titleObserver = wkWebView.observe(\WKWebView.title, options: .new) { [weak self] _, change in
            self?.title = change.newValue as? String
        }
    }
}

