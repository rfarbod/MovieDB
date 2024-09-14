//
//  File.swift
//  
//
//  Created by Farbod Rahiminik on 9/10/24.
//

import Foundation
import UIKit

public extension UIView {
    class func instantiate(
        bundle: Bundle? = nil,
        withOwner owner: Any? = nil,
        options: [UINib.OptionsKey: Any]? = nil
    ) -> Self {
        return _instantiate(bundle: bundle, withOwner: owner, options: options)
    }

    private class func _instantiate<View: UIView>(
        bundle: Bundle? = nil,
        withOwner owner: Any? = nil,
        options: [UINib.OptionsKey: Any]? = nil
    ) -> View {
        let identifier = String(describing: View.self)
        let bundle = bundle ?? .main
        if bundle.path(forResource: identifier, ofType: "nib") != nil {
            let nib = UINib(nibName: identifier, bundle: bundle)
            return nib.instantiate(withOwner: owner, options: options).first as! View
        }

        return View(frame: .zero)
    }
}
