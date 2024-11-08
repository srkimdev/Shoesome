//
//  ShowShoesCollectionViewCell.swift
//  Shopping Application
//
//  Created by 김성률 on 10/20/24.
//

import UIKit
import SnapKit

final class CategoryCollectionViewCell: BaseCollectionViewCell {
    
    private let categoryLabel = {
        let object = UILabel()
        object.textColor = .white
        return object
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    override func configureHierarchy() {
        contentView.addSubview(categoryLabel)
    }
    
    override func configureLayout() {
        categoryLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide)
            make.verticalEdges.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
    
    func designCell(input: String) {
        categoryLabel.text = input
    }
    
}
