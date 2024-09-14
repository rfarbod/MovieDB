//
//  File.swift
//  
//
//  Created by Farbod Rahiminik on 9/14/24.
//

import Foundation
import UIKit

public final class ItemDescriptionView: StatefulView<ItemDescriptionViewModel> {
    private enum Constants {
        static let padding: CGFloat = 15
        static let imageSize: CGFloat = 25
    }

    private lazy var titleLabel: UILabel = .init()
    private lazy var descLabel: UILabel = .init()
    private lazy var voteImage: UIImageView = .init()
    private lazy var voteLabel: UILabel = .init()

    public override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    public override func didChangeModel() {
        super.didChangeModel()

        titleLabel.text = model.title
        voteLabel.text = "\(model.voteAverage) / \(model.voteCount)"
        descLabel.text = model.description
    }

    private func setupView() {
        setupTitleLabel()
        setupVoteImage()
        setupVoteLabel()
        setupDescLabel()
    }

    private func setupTitleLabel() {
        titleLabel.numberOfLines = 0
        titleLabel.font = .preferredFont(forTextStyle: .largeTitle)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.padding)
            make.leading.equalToSuperview().offset(Constants.padding)
            make.trailing.equalToSuperview().inset(Constants.padding)
        }
    }

    private func setupVoteImage() {
        voteImage.image = UIImage(systemName: "star.circle")
        voteImage.tintColor = .systemYellow
        addSubview(voteImage)
        voteImage.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.trailing.equalToSuperview().inset(Constants.padding)
            make.width.height.equalTo(Constants.imageSize)
        }
    }

    private func setupVoteLabel() {
        voteLabel.numberOfLines = 0
        voteLabel.font = .preferredFont(forTextStyle: .caption1)
        addSubview(voteLabel)
        voteLabel.snp.makeConstraints { make in
            make.top.equalTo(voteImage.snp.bottom).offset(Constants.padding)
            make.trailing.equalToSuperview().inset(Constants.padding)
        }
    }

    private func setupDescLabel() {
        descLabel.numberOfLines = 0
        descLabel.font = .preferredFont(forTextStyle: .subheadline)
        addSubview(descLabel)
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(voteLabel.snp.bottom).offset(Constants.padding)
            make.leading.equalToSuperview().offset(Constants.padding)
            make.trailing.equalToSuperview().inset(Constants.padding)
            make.bottom.equalToSuperview().priority(.low)
        }
    }
}
