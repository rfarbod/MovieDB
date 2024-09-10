//
//  File.swift
//  
//
//  Created by Farbod Rahiminik on 9/10/24.
//

import Foundation
import UIKit

open class StatefulView<Model: ViewModelProtocol>: UIView, StatefulViewProtocol {
    public var model: Model = .default {
        didSet { didChangeModel() }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)

        viewDidLoad()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    open override func awakeFromNib() {
        super.awakeFromNib()

        viewDidLoad()
    }

    open func viewDidLoad() {}

    open func didChangeModel() {
        backgroundColor = model.backgroundColor
    }
}
