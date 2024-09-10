//
//  ViewController.swift
//  MovieDB
//
//  Created by Farbod Rahiminik on 9/10/24.
//

import AppUI
import Combine
import UIKit

final class HomeViewController: StatefulViewController<HomeModel> {
    private var viewModel: HomeViewModel
    private lazy var tableView: UITableView = .init()

    private var cancellable: AnyCancellable?

    init(
        viewModel: HomeViewModel
    ) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        tableView.register(cellOfType: ItemThumbnailContainerCell.self)
        tableView.delegate = self
        tableView.dataSource = self

        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        cancellable = viewModel.$model
            .sink { [weak self] updateModel in
                self?.model = updateModel
            }

        viewModel.getItems()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        cancellable?.cancel()
    }

    override func didChangeModel() {
        super.didChangeModel()

        tableView.reloadData()
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cellOfType: ItemThumbnailContainerCell.self, for: indexPath) { _ in
            return model.items[indexPath.row]
        }

        return cell
    }
}

extension HomeViewController: UITableViewDelegate {}

