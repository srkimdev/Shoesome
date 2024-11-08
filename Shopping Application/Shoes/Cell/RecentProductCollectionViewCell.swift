//
//  RecentProductCollectionViewCell.swift
//  Shopping Application
//
//  Created by 김성률 on 10/20/24.
//

import UIKit
import SnapKit

final class RecentProductCollectionViewCell: BaseCollectionViewCell {
    
    private let background = {
        let object = UIView()
        object.clipsToBounds = true
        object.layer.cornerRadius = 10
        return object
    }()
    
    private let shoesImage = {
        let object = UIImageView()
        return object
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    
    override func configureHierarchy() {
        contentView.addSubview(background)
        background.addSubview(shoesImage)
    }
    
    override func configureLayout() {
        background.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        shoesImage.snp.makeConstraints { make in
            make.edges.equalTo(background)
        }
    }
    
    func designCell(item: SearchResultDetail) {
        shoesImage.setImage(item.image)
    }
    
}
