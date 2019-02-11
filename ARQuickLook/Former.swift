//
//  Former.swift
//  ARQuickLook
//
//  Created by Shota Nakagami on 2019/02/11.
//  Copyright © 2019 Shota Nakagami. All rights reserved.
//

import Former
import UIKit

enum MyFormer {
    static func makeHeader(title: String, height: CGFloat = 60) -> LabelViewFormer<FormLabelHeaderView> {
        return LabelViewFormer<FormLabelHeaderView>()
            .configure {
                $0.text = title
                $0.viewHeight = height
        }
    }
    
    static func makeLabelRow(title: String, onSelected: @escaping () -> Void) -> LabelRowFormer<FormLabelCell> {
        return LabelRowFormer<FormLabelCell>() {
                $0.selectionStyle = .none
                $0.accessoryType = .disclosureIndicator
            }
            .configure {
                $0.text = title
                $0.rowHeight = 60
            }.onSelected { _ in
                onSelected()
        }
    }
}
