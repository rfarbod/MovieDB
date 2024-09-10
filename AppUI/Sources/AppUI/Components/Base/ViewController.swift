//
//  File.swift
//
//
//  Created by Farbod Rahiminik on 9/10/24.
//

import Foundation
import UIKit

open class ViewController: UIViewController {
    private var onDismissCallback: VoidCallback?

    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        if isMovingFromParent || isBeingDismissed {
            onDismissCallback?()
        }
    }

    public func onDismiss(_ callback: @escaping VoidCallback) {
        onDismissCallback = callback
    }
}
