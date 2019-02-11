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
    let url: URL
    
    init(url: URL) {
        self.url = url
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
        // URL must be a file-type URL (local files only)
        return url as QLPreviewItem
    }
}

