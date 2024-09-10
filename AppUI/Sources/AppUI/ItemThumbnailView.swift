//
//  File.swift
//  
//
//  Created by Farbod Rahiminik on 9/10/24.
//

import Foundation
import SnapKit
import UIKit

final class ItemThumbnailView: StatefulView<ItemThumbnailViewModel> {
    private enum Constants {
        static let cornerRadius: CGFloat = 15
        static let padding: CGFloat = 10
        static let imageViewHeight: CGFloat = 75
        static let imageViewWidth: CGFloat = 50
        static let ratingHeight: CGFloat = 25
        static let ratingWidth: CGFloat = 25
    }

    private lazy var imageView: UIImageView = .init()
    private lazy var titleLabel: UILabel = .init()
    private lazy var ratingImage: UIImageView = .init()
    private lazy var ratingLabel: UILabel = .init()
    private lazy var descLabel: UILabel = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.layer.cornerRadius = Constants.cornerRadius
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().offset(Constants.padding)
            make.height.equalTo(Constants.imageViewHeight)
            make.width.equalTo(Constants.imageViewWidth)
        }

        ratingImage.image = UIImage(systemName: "star.circle")
        ratingImage.tintColor = .systemYellow
        addSubview(ratingImage)
        ratingImage.snp.makeConstraints { [weak self] make in
            guard let self else { return }

            make.top.trailing.equalTo(self.imageView).offset(Constants.padding)
            make.height.equalTo(Constants.ratingHeight)
            make.width.equalTo(Constants.ratingWidth)
        }

        ratingLabel.font = .preferredFont(forTextStyle: .caption2)
        ratingLabel.numberOfLines = 0
        addSubview(ratingLabel)
        ratingLabel.snp.makeConstraints { [weak self] make in
            guard let self else { return }

            make.top.equalTo(self.ratingImage.snp.bottom).offset(Constants.padding)
            make.trailing.equalTo(self.imageView).offset(Constants.padding)
        }

        titleLabel.font = .preferredFont(forTextStyle: .title1)
        titleLabel.numberOfLines = 0
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { [weak self] make in
            guard let self else { return }

            make.top.leading.equalToSuperview().offset(Constants.padding)
            make.trailing.equalTo(self.ratingLabel.snp.leading).offset(Constants.padding)
        }

        descLabel.font = .preferredFont(forTextStyle: .caption2)
        descLabel.numberOfLines = 0
        addSubview(descLabel)
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.padding)
            make.leading.equalToSuperview().offset(Constants.padding)
            make.trailing.equalTo(self.ratingLabel.snp.leading).offset(Constants.padding)
        }
    }

    override func didChangeModel() {
        super.didChangeModel()

        titleLabel.text = model.title
        ratingLabel.text = "\(model.rating.rounded())"
        descLabel.text = model.description
    }
}
