//
//  ListViewController.swift
//  ARQuickLook
//
//  Created by Shota Nakagami on 2018/07/11.
//  Copyright © 2018年 Shota Nakagami. All rights reserved.
//

import UIKit
import SnapKit
import Former
import SVProgressHUD
import Alamofire

class ListViewController: UIViewController {
    private let galleryUrlString = "https://developer.apple.com/arkit/gallery/"
    private let usdzUrlString = "https://developer.apple.com/arkit/gallery/models/teapot/teapot.usdz" //6.6MB
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
            MyFormer.makeLabelRow(title: "Native (Local File)") { [weak self] in
                self?.openInNativeWithLocalFile()
            },
            MyFormer.makeLabelRow(title: "Native (Web File)") { [weak self] in
                self?.openInNativeWithWebFile()
            },
            MyFormer.makeLabelRow(title: "WebView (Gallery)") { [weak self] in
                self?.openInWebViewForGallery()
            },
            MyFormer.makeLabelRow(title: "WebView (usdz)") { [weak self] in
                self?.openInWebViewForUSDZ()
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
    
    func openInNativeWithWebFile() {
        SVProgressHUD.show(withStatus: "Loading")
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent("teapot.usdz")
            
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        Alamofire.download(usdzUrlString, to: destination).responseData { [weak self] response in
            guard let url = response.destinationURL else {
                SVProgressHUD.showError(withStatus: "Loading Failed")
                return
            }
            SVProgressHUD.dismiss()
            DispatchQueue.main.async {
                let vc = ARNativeViewController(url: url)
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    func openInNativeWithLocalFile() {
        guard let url = Bundle.main.url(forResource: "cupandsaucer", withExtension: "usdz") else { return }
        let vc = ARNativeViewController(url: url)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func openInWebViewForGallery() {
        guard let url = URL(string: galleryUrlString) else { return }
        let vc = WebViewController(url: url)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func openInWebViewForUSDZ() {
        guard let url = URL(string: usdzUrlString) else { return }
        let vc = WebViewController(url: url)
        navigationController?.pushViewController(vc, animated: true)
    }
}
