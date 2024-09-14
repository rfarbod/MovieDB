//
//  File.swift
//  
//
//  Created by Farbod Rahiminik on 9/13/24.
//

import Foundation
import UIKit

public final class ItemDetailsView: StatefulView<ItemDetailsViewModel> {
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
        3
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

        case 1:
            let cell = tableView.dequeue(cellOfType: TitleImageContainerCell.self, for: indexPath) { indexPath in
                return .init(
                    title: model.genres[indexPath.row],
                    imagePath: ""
                )
            }
            cell.selectionStyle = .none
            return cell

        case 2:
            let cell = tableView.dequeue(cellOfType: TitleImageContainerCell.self, for: indexPath) { indexPath in
                return .init(
                    title: model.logos[indexPath.row].1,
                    imagePath: model.logos[indexPath.row].2
                )
            }
            cell.selectionStyle = .none
            return cell

        default:
            return UITableViewCell()
        }
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1

        case 1:
            return model.genres.count

        case 2:
            return model.logos.count

        default:
            return 0
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
            label.font = .systemFont(ofSize: 15, weight: .medium)
            label.text = section == 1 ? "Genres" : "Production Companies"
            view.addSubview(label)

            label.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.leading.equalToSuperview().inset(15)
                make.bottom.trailing.equalToSuperview().offset(15)
            }
            return view
        }
    }
}

extension ItemDetailsView: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 300
        } else {
            return 50
        }
    }
}
