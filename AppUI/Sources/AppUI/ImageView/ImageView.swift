//
//  File.swift
//  
//
//  Created by Farbod Rahiminik on 9/13/24.
//

import Foundation
import UIKit

public final class ImageView: StatefulView<ImageViewModel> {
    private lazy var imageView: UIImageView = .init()

    public override func viewDidLoad() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    public override func didChangeModel() {
        super.didChangeModel()

        imageView.sd_setImage(with: URL(string: model.imagePath))
    }
}
