//
//  UIImageView+.swift
//  Shopping Application
//
//  Created by 김성률 on 10/19/24.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(_ url: String?) {
        guard let url = url, let source = URL(string: url) else { return }
        kf.setImage(with: source, placeholder: UIImage(named: "shop-placeholder"), options: [
            .transition(.fade(1)),
            .forceTransition,
            .processor(DownsamplingImageProcessor(size: CGSize(width: 300, height: 400))),
            .scaleFactor(UIScreen.main.scale),
            .progressiveJPEG(.init(isBlur: false, isFastestScan: true, scanInterval: 0.1)),
            .cacheOriginalImage
        ])
    }
}
