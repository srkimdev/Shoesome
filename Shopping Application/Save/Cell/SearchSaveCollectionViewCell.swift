//
//  SearchSaveCollectionViewCell.swift
//  Shopping Application
//
//  Created by 김성률 on 7/7/24.
//

import UIKit
import SnapKit

final class SearchSaveCollectionViewCell: BaseCollectionViewCell {
    
    private let background = {
        let object = UIView()
        object.layer.cornerRadius = 10
        object.backgroundColor = #colorLiteral(red: 0.9677416682, green: 0.9727140069, blue: 0.9898334146, alpha: 1)
        return object
    }()
    
    private let productImage = {
        let object = UIImageView()
        object.clipsToBounds = true
        object.layer.cornerRadius = 10
        return object
    }()
    
    private let productLabel = {
        let object = UILabel()
        object.numberOfLines = 2
        object.font = .systemFont(ofSize: 17, weight: .bold)
        return object
    }()
    
    private let likeButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.baseForegroundColor = .red
        configuration.baseBackgroundColor = .clear
        
        let heartImage = UIImage(systemName: "heart.fill")
        configuration.image = heartImage
        configuration.imagePadding = 8
        
        let button = UIButton(configuration: configuration)
        
        return button
    }()
    
    private let categoryLabel = {
        let object = UILabel()
        object.font = .systemFont(ofSize: 13)
        object.textColor = .gray
        return object
    }()
    
    private let priceLabel = {
        let object = UILabel()
        object.font = .systemFont(ofSize: 17, weight: .bold)
        return object
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    override func configureHierarchy() {
        contentView.addSubview(background)
        background.addSubview(productImage)
        background.addSubview(likeButton)
        background.addSubview(productLabel)
        background.addSubview(categoryLabel)
        background.addSubview(priceLabel)
    }
    
    override func configureLayout() {
        background.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        productImage.snp.makeConstraints { make in
            make.verticalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(16)
            make.width.equalTo(productImage.snp.height)
        }
        
        likeButton.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(12)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(12)
            make.size.equalTo(30)
        }
        
        productLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(16)
            make.leading.equalTo(productImage.snp.trailing).offset(16)
            make.trailing.equalTo(likeButton.snp.leading).inset(-16)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(productLabel.snp.bottom).offset(8)
            make.leading.equalTo(productImage.snp.trailing).offset(16)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(16)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.bottom.equalTo(productImage.snp.bottom)
            make.leading.equalTo(productImage.snp.trailing).offset(16)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(16)
        }
    }
    
    func designCell(_ transition: SearchResultDetail) {
        productImage.setImage(transition.image)
        
        productLabel.text = HTMLManager.shared.changeHTML(text: transition.title)
        categoryLabel.text = transition.category3
        priceLabel.text = "₩" + NumberFormatterManager.shared.Comma(Int(transition.lprice) ?? 0)
    }
}
