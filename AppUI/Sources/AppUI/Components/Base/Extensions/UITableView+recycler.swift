//
//  File.swift
//  
//
//  Created by Farbod Rahiminik on 9/10/24.
//

import Foundation
import UIKit

public extension UITableView {
    func register<CellType: UITableViewCell>(cellOfType cellType: CellType.Type) {
        let identifier = String(describing: cellType)
        if Bundle.main.path(forResource: identifier, ofType: "nib") != nil {
            register(UINib(nibName: identifier, bundle: .main), forCellReuseIdentifier: identifier)
        } else {
            register(cellType, forCellReuseIdentifier: identifier)
        }
    }

    func register<HeaderFooterViewType: UITableViewHeaderFooterView>(headerFooterViewOfType headerFooterViewType: HeaderFooterViewType.Type) {
        let identifier = String(describing: headerFooterViewType)
        if Bundle.main.path(forResource: identifier, ofType: "nib") != nil {
            register(UINib(nibName: identifier, bundle: .main), forHeaderFooterViewReuseIdentifier: identifier)
        } else {
            register(headerFooterViewType, forHeaderFooterViewReuseIdentifier: identifier)
        }
    }

    func dequeue<HeaderFooterView: UITableViewHeaderFooterView>(headerFooterViewOfType headerFooterViewType: HeaderFooterView.Type) -> HeaderFooterView {
        return dequeueReusableHeaderFooterView(withIdentifier: String(describing: headerFooterViewType)) as! HeaderFooterView
    }

    func dequeue<Cell: UITableViewCell>(cellOfType cellType: Cell.Type, for indexPath: IndexPath) -> Cell {
        return dequeueReusableCell(withIdentifier: String(describing: cellType), for: indexPath) as! Cell
    }
}

public extension UITableView {
    func dequeue<View: StatefulViewProtocol, Cell: ContainerTableViewCell<View>>(
        cellOfType cellType: Cell.Type,
        for indexPath: IndexPath,
        _ buildModel: (IndexPath) -> View.Model
    ) -> Cell {
        let cell = dequeue(cellOfType: cellType, for: indexPath)
        cell.model = buildModel(indexPath)
        return cell
    }
}
