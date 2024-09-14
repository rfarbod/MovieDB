//
//  File.swift
//  
//
//  Created by Farbod Rahiminik on 9/11/24.
//

import Foundation
import SnapKit
import UIKit

public extension UIView {
    public func addLoadingIndicator() {
        let loadingIndicator: UIActivityIndicatorView = .init()
        addSubview(loadingIndicator)
        loadingIndicator.tag = 42
        loadingIndicator.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.width.equalTo(25)
        }
        loadingIndicator.startAnimating()
    }

    public func removeLoadingIndicator() {
        for each in subviews {
            if each.tag == 42 {
                each.removeFromSuperview()
            }
        }
    }
}
