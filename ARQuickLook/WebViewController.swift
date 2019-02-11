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
import SVProgressHUD

class WebViewController: UIViewController {
    let url: URL
    private var titleObserver: NSKeyValueObservation?
    private var isLoadingObserver: NSKeyValueObservation?
    
    lazy var wkWebView = WKWebView().then {
        let request = URLRequest(url: url)
        $0.load(request)
    }
    
    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
        if wkWebView.isLoading {
            SVProgressHUD.show(withStatus: "Loading")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLayout()
        observeTitle()
        observeIsLoading()
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
    
    func observeIsLoading() {
        isLoadingObserver = wkWebView.observe(\WKWebView.isLoading, options: .new) { _, change in
            guard let isLoading = change.newValue else { return }
            isLoading ? SVProgressHUD.show(withStatus: "Loading") : SVProgressHUD.dismiss()
        }
    }
}

