//
//  ProductCollectionViewCell.swift
//  Shopping Application
//
//  Created by 김성률 on 10/20/24.
//

import UIKit
import SnapKit

final class ProductCollectionViewCell: BaseCollectionViewCell {
    
    private let background = {
        let object = UIView()
        object.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.9568627477, blue: 0.9568627477, alpha: 1)
        object.layer.cornerRadius = 10
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
    
    private let shoesImage = {
        let object = UIImageView()
        object.layer.cornerRadius = 10
        object.clipsToBounds = true
        return object
    }()
    
    private let productNameLabel = {
        let object = UILabel()
        object.font = .systemFont(ofSize: 22, weight: .bold)
        object.numberOfLines = 2
        return object
    }()
    
    private let categoryLabel = {
        let object = UILabel()
        object.font = .systemFont(ofSize: 13)
        object.textColor = .gray
        return object
    }()
    
    private let priceLabel = {
        let object = UILabel()
        object.font = .systemFont(ofSize: 18, weight: .bold)
        return object
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    
    override func configureHierarchy() {
        contentView.addSubview(background)
        background.addSubview(likeButton)
        background.addSubview(shoesImage)
        background.addSubview(productNameLabel)
        background.addSubview(categoryLabel)
        background.addSubview(priceLabel)
    }
    
    override func configureLayout() {
        background.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        likeButton.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(12)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(12)
            make.size.equalTo(40)
        }
        
        shoesImage.snp.makeConstraints { make in
            make.top.equalTo(likeButton.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(contentView).multipliedBy(0.4)
        }
        
        productNameLabel.snp.makeConstraints { make in
            make.top.equalTo(shoesImage.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(60)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(productNameLabel.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(20)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(16)
        }
    }
    
    func designCell(item: SearchResultDetail) {
        shoesImage.setImage(item.image)
        shoesImage.contentMode = .scaleAspectFill
        
        categoryLabel.text = item.category3
        productNameLabel.text = HTMLManager.shared.changeHTML(text: item.title)
        priceLabel.text = "₩" + NumberFormatterManager.shared.Comma(Int(item.lprice) ?? 0)
    }
    
}
