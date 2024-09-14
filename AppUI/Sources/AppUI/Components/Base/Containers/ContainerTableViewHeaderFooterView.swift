//
//  File.swift
//  
//
//  Created by Farbod Rahiminik on 9/13/24.
//

import Foundation

open class ContainerTableViewHeaderFooterView<ContentView: StatefulViewProtocol>: TableViewHeaderFooterView {
    class var isDynamicallyResizable: Bool { return false }

    private(set) lazy var view: ContentView = .instantiate()

    public var model: ContentView.Model {
        get { return view.model }
        set {
            view.model = newValue
            perform(#selector(didChangeModel))
        }
    }

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        defaultInit()
        perform(#selector(viewDidLoad))
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)

        defaultInit()
    }

    override open func awakeFromNib() {
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

    override open func prepareForReuse() {
        super.prepareForReuse()

        view.model = .default
        perform(#selector(didChangeModel))
    }
}
