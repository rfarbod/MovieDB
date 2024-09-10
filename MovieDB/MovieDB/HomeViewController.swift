//
//  ViewController.swift
//  MovieDB
//
//  Created by Farbod Rahiminik on 9/10/24.
//

import AppUI
import UIKit

class HomeViewController: UIViewController {
    private lazy var tableView: UITableView = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground

        tableView.register(cellOfType: ItemThumbnailContainerCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()

        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cellOfType: ItemThumbnailContainerCell.self, for: indexPath) { _ in
            return .default
        }

        return cell
    }
}

extension HomeViewController: UITableViewDelegate {}

