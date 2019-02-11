//
//  SafariViewController.swift
//  ARQuickLook
//
//  Created by Shota Nakagami on 2019/02/11.
//  Copyright © 2019 Shota Nakagami. All rights reserved.
//

import SafariServices
import UIKit

public final class SafariViewController: SFSafariViewController {
    let url: URL
    
    init(url: URL) {
        self.url = url
        super.init(url: url, configuration: Configuration())
    }
}
