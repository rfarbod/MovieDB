//
//  File.swift
//  
//
//  Created by Farbod Rahiminik on 9/10/24.
//

import Foundation
import UIKit

public protocol StatefulViewProtocol: UIView {
    associatedtype Model: ViewModelProtocol

    var model: Model { get set }
}
