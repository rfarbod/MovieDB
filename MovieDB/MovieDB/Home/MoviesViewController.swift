//
//  ViewController.swift
//  MovieDB
//
//  Created by Farbod Rahiminik on 9/10/24.
//

import AppUI
import Combine
import UIKit

final class MoviesViewController: StatefulViewController<MoviesModel> {
    private var viewModel: MoviesViewModel
    private lazy var tableView: UITableView = .init()

    private var cancellable: AnyCancellable?

    init(
        viewModel: MoviesViewModel
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
        
        tableView.accessibilityIdentifier = "MoviesTableView"
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

        if model.isLoading {
            view.addLoadingIndicator()
        } else {
            view.removeLoadingIndicator()
        }
    }
}

extension MoviesViewController: UITableViewDataSource {
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

extension MoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController: MovieDetailsViewController = .init(viewModel: .init(model: .init(
            isLoading: true,
            movieId: model.items[indexPath.row].id
        )))

        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension MoviesViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height

        if offsetY > contentHeight - frameHeight {
            viewModel.getItems()
        }
    }
}
