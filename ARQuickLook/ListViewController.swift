//
//  ListViewController.swift
//  ARQuickLook
//
//  Created by Shota Nakagami on 2018/07/11.
//  Copyright © 2018年 Shota Nakagami. All rights reserved.
//

import UIKit
import SnapKit
import QuickLook
import Former

class ListViewController: UIViewController {
    private let galleryUrlString = "https://developer.apple.com/arkit/gallery/"
    private let usdzUrlString = "https://developer.apple.com/arkit/gallery/models/teapot/teapot.usdz"
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private lazy var former = Former(tableView: tableView)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "ARKit Sample"
        updateLayout()
        setUpFormer()
    }
    
    func setUpFormer() {
        let section = SectionFormer(rowFormers: [
            MyFormer.makeLabelRow(title: "QLPreviewController") { [weak self] in
                self?.openInNative()
            },
            MyFormer.makeLabelRow(title: "WKWebView") { [weak self] in
                self?.openInWebView()
            },
            MyFormer.makeLabelRow(title: "Safari") { [weak self] in
                self?.openInSafari()
            }
            ])
        former.add(sectionFormers: [section])
    }
    
    func updateLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges .equalToSuperview()
        }
    }
    
    func openInSafari() {
        guard let url = URL(string: galleryUrlString) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func openInNative() {
        guard let url = Bundle.main.url(forResource: "cupandsaucer", withExtension: "usdz") else { return }
        let vc = ARNativeViewController(url: url)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func openInWebView() {
        guard let url = URL(string: galleryUrlString) else { return }
        let vc = WebViewController(url: url)
        navigationController?.pushViewController(vc, animated: true)
    }
}
