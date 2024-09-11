//
//  File.swift
//  
//
//  Created by Farbod Rahiminik on 9/10/24.
//

import Foundation
import SnapKit
import SDWebImage
import UIKit

public final class ItemThumbnailView: StatefulView<ItemThumbnailViewModel> {
    private enum Constants {
        static let cornerRadius: CGFloat = 15
        static let padding: CGFloat = 10
        static let imageViewHeight: CGFloat = 150
        static let imageViewWidth: CGFloat = 100
        static let ratingHeight: CGFloat = 25
        static let ratingWidth: CGFloat = 25
    }

    private lazy var imageView: UIImageView = .init()
    private lazy var titleLabel: UILabel = .init()
    private lazy var ratingImage: UIImageView = .init()
    private lazy var ratingLabel: UILabel = .init()
    private lazy var descLabel: UILabel = .init()

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.layer.cornerRadius = Constants.cornerRadius
        imageView.backgroundColor = .orange
        imageView.clipsToBounds = true
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(Constants.padding)
            make.bottom.equalToSuperview().inset(Constants.padding).priority(.low)
            make.height.equalTo(Constants.imageViewHeight)
            make.width.equalTo(Constants.imageViewWidth)
        }

        ratingImage.image = UIImage(systemName: "star.circle")
        ratingImage.tintColor = .systemYellow
        addSubview(ratingImage)
        ratingImage.snp.makeConstraints { [weak self] make in
            guard let self else { return }

            make.top.equalTo(self.imageView).offset(Constants.padding)
            make.trailing.equalTo(self.imageView.snp.leading).offset(-Constants.padding)
            make.height.equalTo(Constants.ratingHeight)
            make.width.equalTo(Constants.ratingWidth)
        }

        ratingLabel.font = .preferredFont(forTextStyle: .caption2)
        ratingLabel.textAlignment = .right
        ratingLabel.numberOfLines = 0
        addSubview(ratingLabel)
        ratingLabel.snp.makeConstraints { [weak self] make in
            guard let self else { return }

            make.top.equalTo(self.ratingImage.snp.bottom).offset(Constants.padding)
            make.trailing.equalTo(self.imageView.snp.leading).offset(-Constants.padding)
            make.width.equalTo(Constants.ratingWidth)
        }

        titleLabel.font = .preferredFont(forTextStyle: .title1)
        titleLabel.numberOfLines = 0
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { [weak self] make in
            guard let self else { return }

            make.top.leading.equalToSuperview().offset(Constants.padding)
            make.trailing.equalTo(self.ratingLabel.snp.leading).inset(Constants.padding)
        }

        descLabel.font = .preferredFont(forTextStyle: .caption2)
        descLabel.numberOfLines = 0
        addSubview(descLabel)
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.padding)
            make.leading.equalToSuperview().offset(Constants.padding)
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.greaterThanOrEqualTo(imageView.snp.height)
            make.bottom.equalToSuperview().inset(Constants.padding).priority(.high)
        }
    }

    public override func didChangeModel() {
        super.didChangeModel()

        titleLabel.text = model.title
        ratingLabel.text = "\(model.rating.rounded())"
        descLabel.text = model.description

        imageView.contentMode = .scaleAspectFit
        imageView.sd_setImage(with: URL(string: model.imagePath))
    }
}
