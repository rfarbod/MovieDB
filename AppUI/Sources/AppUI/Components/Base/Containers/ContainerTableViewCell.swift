//
//  File.swift
//  
//
//  Created by Farbod Rahiminik on 9/10/24.
//

import Foundation
import SnapKit
import UIKit

open class ContainerTableViewCell<ContentView: StatefulViewProtocol>: TableViewCell {
    open class var isDynamicallyResizable: Bool { return true }

    public private(set) lazy var view: ContentView = .init()

    public var model: ContentView.Model {
        get { return view.model }
        set {
            view.model = newValue
            perform(#selector(didChangeModel))
        }
    }

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        defaultInit()
        perform(#selector(viewDidLoad))
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        defaultInit()
    }

    open override func awakeFromNib() {
        super.awakeFromNib()

        perform(#selector(viewDidLoad))
    }

    private func defaultInit() {
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)

        if type(of: self).isDynamicallyResizable {
            view.snp.makeConstraints { make in
                make.top.leading.trailing.equalToSuperview()
                make.bottom.equalToSuperview().priority(.low)
            }
        } else {
            view.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
    }

    open override func prepareForReuse() {
        super.prepareForReuse()

        view.model = .default
        perform(#selector(didChangeModel))
    }
}
