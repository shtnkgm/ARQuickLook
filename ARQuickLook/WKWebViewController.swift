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

class WKWebViewController: UIViewController {
    let url: URL
    private var titleObserver: NSKeyValueObservation?
    private var progressObserver: NSKeyValueObservation?
    
    lazy var wkWebView = WKWebView().then {
        let request = URLRequest(url: url)
        $0.load(request)
        $0.navigationDelegate = self
    }
    
    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
        if wkWebView.isLoading {
            SVProgressHUD.showProgress(0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLayout()
        observeTitle()
        observeProgress()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        SVProgressHUD.dismiss()
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
    
    func observeProgress() {
        progressObserver = wkWebView.observe(\WKWebView.estimatedProgress, options: .new) { _, change in
            guard let progress = change.newValue else { return }
            SVProgressHUD.showProgress(Float(progress))
            if progress == 1 {
                SVProgressHUD.dismiss()
            }
        }
    }
}

extension WKWebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        SVProgressHUD.showError(withStatus: "")
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        SVProgressHUD.showError(withStatus: "")
    }
}

