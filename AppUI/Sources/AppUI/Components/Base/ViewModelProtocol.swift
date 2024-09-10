//
//  File.swift
//  
//
//  Created by Farbod Rahiminik on 9/10/24.
//

import Foundation
import UIKit

public protocol ViewModelProtocol {
    static var `default`: Self { get }

    var backgroundColor: UIColor { get }
}

extension ViewModelProtocol {
    public var backgroundColor: UIColor { return .clear }
}
