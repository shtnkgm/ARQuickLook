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
    private let localUSDZURL = Bundle.main.url(forResource: "cupandsaucer", withExtension: "usdz")!
    private let galleryUrl = URL(string: "https://developer.apple.com/arkit/gallery/")!
    private let usdzUrl = URL(string: "https://developer.apple.com/arkit/gallery/models/teapot/teapot.usdz")! //6.6MB
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
                guard let self = self else { return }
                self.openInNative(url: self.localUSDZURL)
            },
            MyFormer.makeLabelRow(title: "Native (Web File)") { [weak self] in
                guard let self = self else { return }
                self.openInNativeWithWebFile(url: self.usdzUrl)
            },
            MyFormer.makeLabelRow(title: "WebView (Gallery)") { [weak self] in
                guard let self = self else { return }
                self.openInWebView(url: self.galleryUrl)
            },
            MyFormer.makeLabelRow(title: "WebView (usdz)") { [weak self] in
                guard let self = self else { return }
                self.openInWebView(url: self.usdzUrl)
            },
            MyFormer.makeLabelRow(title: "Safari") { [weak self] in
                guard let self = self else { return }
                self.openInSafari(url: self.galleryUrl)
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
    
    func openInNativeWithWebFile(url: URL) {
        SVProgressHUD.show(withStatus: "Loading")
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent("teapot.usdz")
            
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        Alamofire.download(url.absoluteString, to: destination)
            .downloadProgress { progress in
                SVProgressHUD.showProgress(Float(progress.fractionCompleted))
            }
            .responseData { [weak self] response in
                guard let url = response.destinationURL else {
                    SVProgressHUD.showError(withStatus: "Loading Failed")
                    return
                }
                SVProgressHUD.dismiss()
                DispatchQueue.main.async {
                    self?.openInNative(url: url)
                }
        }
    }
    
    func openInNative(url: URL) {
        let vc = ARNativeViewController(url: url)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func openInWebView(url: URL) {
        let vc = WebViewController(url: url)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func openInSafari(url: URL) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
