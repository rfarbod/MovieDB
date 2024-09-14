//
//  MovieDetailsViewController.swift
//  MovieDB
//
//  Created by Farbod Rahiminik on 9/13/24.
//

import AppUI
import Combine
import Foundation
import UIKit

final class MovieDetailsViewController: StatefulViewController<MovieDetailsModel> {
    private var viewModel: MovieDetailsViewModel

    private lazy var scrollView: UIScrollView = .init()
    private lazy var contentView: UIView = .init()
    private lazy var detailsView: ItemDetailsView = .instantiate()

    private var cancellable: AnyCancellable?

    init(
        viewModel: MovieDetailsViewModel
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

        scrollView.delegate = self
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().priority(.low)
        }

        contentView.addSubview(detailsView)
        detailsView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        detailsView.accessibilityIdentifier = "MovieDetailsView"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        cancellable = viewModel.$model
            .sink { [weak self] updateModel in
                self?.model = updateModel
            }

        viewModel.getMovieDetails()
    }

    override func didChangeModel() {
        super.didChangeModel()

        detailsView.model = model.itemDetailsViewModel
        title = model.itemDetailsViewModel.title
        detailsView.layoutIfNeeded()
    }
}

extension MovieDetailsViewController: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let headerView = detailsView.tableView.headerView(forSection: 0) else { return }

        let offsetY = scrollView.contentOffset.y
        if offsetY < 0 {
            headerView.frame = CGRect(x: headerView.frame.origin.x, y: offsetY, width: detailsView.tableView.frame.width, height: 300 - offsetY)
        }
    }
}
