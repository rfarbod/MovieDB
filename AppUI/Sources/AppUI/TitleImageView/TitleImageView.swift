//
//  File.swift
//
//
//  Created by Farbod Rahiminik on 9/13/24.
//

import Foundation
import UIKit

public final class TitleImageView: StatefulView<TitleImageViewModel> {
    private enum Constants {
        static let size: CGFloat = imageSize + (2 * padding)
        static let imageSize: CGFloat = 30
        static let padding: CGFloat = 5
        static let placeholderImage: UIImage? = UIImage(systemName: "popcorn")
    }

    private lazy var imageView: UIImageView = .init()
    private lazy var titleLabel: UILabel = .init()
    private lazy var stack: UIStackView = .init()

    public override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    private func setupView() {
        setupImageView()
        setupTitleLabel()
        setupStackView()
    }

    private func setupStackView() {
        stack.spacing = Constants.padding
        stack.distribution = .fill
        stack.alignment = .center
        stack.axis = .horizontal
        stack.addArrangedSubview(imageView)
        stack.addArrangedSubview(titleLabel)
        addSubview(stack)
        stack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Constants.padding)
            make.height.equalTo(Constants.size)
        }
    }

    private func setupImageView() {
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.tintColor = .systemGray
        imageView.snp.makeConstraints { make in
            make.height.width.equalTo(Constants.imageSize)
        }
    }

    private func setupTitleLabel() {
        titleLabel.numberOfLines = 0
        titleLabel.font = .preferredFont(forTextStyle: .subheadline)
    }

    public override func didChangeModel() {
        super.didChangeModel()

        imageView.image = nil
        imageView.sd_setImage(
            with: URL(string: model.imagePath),
            placeholderImage: Constants.placeholderImage
        )

        titleLabel.text = model.title
    }
}
