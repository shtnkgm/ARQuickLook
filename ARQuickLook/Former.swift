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
        return LabelRowFormer<FormLabelCell>()
            .configure {
                $0.text = title
            }.onSelected { _ in
                onSelected()
        }
    }
    
    static func makeSwitchRow(title: String, isOn: Bool = false, onSwitchChanged: @escaping (_ isOn: Bool) -> Void) -> SwitchRowFormer<FormSwitchCell> {
        return SwitchRowFormer<FormSwitchCell> {
            $0.titleLabel.text = title
            $0.switchButton.isOn = isOn
            }.onSwitchChanged {
                onSwitchChanged($0)
        }
    }
    
    static func makeSliderRow(title: String, min: Float = 0, max: Float = 1, value: Float? = nil, onValueChanged: @escaping (_ value: Float) -> Void) -> SliderRowFormer<FormSliderCell> {
        return SliderRowFormer<FormSliderCell> {
            $0.titleLabel.text = title
            $0.slider.minimumValue = min
            $0.slider.maximumValue = max
            }.configure {
                $0.value = value ?? ((min + max) / 2.0)
            }.onValueChanged {
                onValueChanged($0)
        }
    }
}
