//
//  File.swift
//  
//
//  Created by Farbod Rahiminik on 9/10/24.
//

import Foundation
import UIKit

open class StatefulViewController<Model: ViewModelProtocol>: ViewController {
    public var model: Model = .default {
        didSet { didChangeModel() }
    }

    open func didChangeModel() {}
}
