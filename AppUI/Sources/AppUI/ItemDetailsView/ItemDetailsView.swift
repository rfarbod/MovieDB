//
//  File.swift
//  
//
//  Created by Farbod Rahiminik on 9/13/24.
//

import Foundation
import UIKit

public final class ItemDetailsView: StatefulView<ItemDetailsViewModel> {
    private enum Constants {
        static let heightForHeader0: CGFloat = 300
        static let heightForOtherHeaders: CGFloat = 50
        static let padding: CGFloat = 15
        static let fontSize: CGFloat = 15
    }

    public lazy var tableView: UITableView = .init(frame: .zero, style: .plain)

    public override func viewDidLoad() {
        super.viewDidLoad()

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(cellOfType: TitleImageContainerCell.self)
        tableView.register(cellOfType: ItemDescriptionContainerCell.self)
        tableView.register(headerFooterViewOfType: ImageContainerHeader.self)
        tableView.dataSource = self
        tableView.delegate = self
        addSubview(tableView)
    }

    public override func didChangeModel() {
        super.didChangeModel()

        tableView.reloadData()
        tableView.layoutIfNeeded()
        tableView.snp.removeConstraints()
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(tableView.contentSize.height)
        }
    }
}

extension ItemDetailsView: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        model.sections.count + 1
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeue(cellOfType: ItemDescriptionContainerCell.self, for: indexPath) { indexPath in
                return .init(
                    title: model.title,
                    description: model.description,
                    voteAverage: model.rate,
                    voteCount: model.rateCount
                )
            }

            cell.selectionStyle = .none
            return cell

        default:
            let cell = tableView.dequeue(cellOfType: TitleImageContainerCell.self, for: indexPath) { indexPath in
                return .init(
                    title: model.sections[indexPath.section - 1][indexPath.row].title,
                    imagePath: model.sections[indexPath.section - 1][indexPath.row].imagePath
                )
            }
            cell.selectionStyle = .none
            return cell
        }
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1

        default:
            return model.sections[section - 1].count
        }
    }

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let view = tableView.dequeue(headerFooterViewOfType: ImageContainerHeader.self)
            view.model = .init(imagePath: model.imagePath)
            return view
        } else {
            let view = UIView()
            let label = UILabel()
            label.font = .systemFont(ofSize: Constants.fontSize, weight: .medium)
            label.text = section == 1 ? "Genres" : "Production Companies"
            view.addSubview(label)

            label.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.leading.equalToSuperview().inset(Constants.padding)
                make.bottom.trailing.equalToSuperview().offset(Constants.padding)
            }
            return view
        }
    }
}

extension ItemDetailsView: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return Constants.heightForHeader0
        } else {
            return Constants.heightForOtherHeaders
        }
    }
}
