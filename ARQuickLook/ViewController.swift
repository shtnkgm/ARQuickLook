//
//  ViewController.swift
//  ARQuickLook
//
//  Created by Shota Nakagami on 2018/07/11.
//  Copyright © 2018年 Shota Nakagami. All rights reserved.
//

import UIKit
import PureLayout
// import ActionClosurable
import QuickLook
// import ARKit

class ViewController: UIViewController {
    let urlString = "https://developer.apple.com/arkit/gallery/models/teapot/teapot.usdz"
    
    lazy var tableView: UITableView = {
       let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLayout()
    }
    
    func updateLayout() {
        view.addSubview(tableView)
        tableView.autoPinEdgesToSuperviewEdges()
    }
    
    func openInSafari() {
        guard let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func openInNative() {
        let qlPreviewController = QLPreviewController()
        qlPreviewController.dataSource = self
        present(qlPreviewController, animated: true, completion: nil)
    }
    
    func openInWebView() {
        let webViewController = WebViewController()
        present(webViewController, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0: openInSafari()
        case 1: openInWebView()
        case 2: openInNative()
        default: break
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        switch indexPath.row {
        case 0: cell.textLabel?.text = "Safari"
        case 1: cell.textLabel?.text = "WebView"
        case 2: cell.textLabel?.text = "QLPreviewController"
        default: break
        }
        
        return cell
    }
}

extension ViewController: QLPreviewControllerDataSource {
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        // let url = URL(string: urlString)!
        let url = Bundle.main.url(forResource: "cupandsaucer", withExtension: "usdz")!
        return url as QLPreviewItem
    }
}

