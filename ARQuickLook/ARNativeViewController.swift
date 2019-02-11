//
//  ARNativeViewController.swift
//  ARQuickLook
//
//  Created by Shota Nakagami on 2019/02/11.
//  Copyright © 2019 Shota Nakagami. All rights reserved.
//

import UIKit
import QuickLook

public final class ARNativeViewController: QLPreviewController {
    init() {
        super.init(nibName: nil, bundle: nil)
        dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ARNativeViewController: QLPreviewControllerDataSource {
    public func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }
    
    public func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        // let url = URL(string: urlString)!
        let url = Bundle.main.url(forResource: "cupandsaucer", withExtension: "usdz")!
        return url as QLPreviewItem
    }
}

