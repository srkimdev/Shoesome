//
//  SearchResultCollectionViewCell.swift
//  Shopping Application
//
//  Created by 김성률 on 6/14/24.
//

import UIKit
import SnapKit
import Kingfisher

protocol SearchResultCellDelegate: AnyObject {
    func goodButtonTapped(at index: Int)
}

final class SearchResultCollectionViewCell: BaseCollectionViewCell {
    
    private let productImage: UIImageView = {
        let object = UIImageView()
        return object
    }()
    
    private lazy var likeButton: UIButton = {
//        var configuration = UIButton.Configuration.filled()
//        configuration.baseForegroundColor = .white
//        configuration.baseBackgroundColor = .clear
//        
//        let heartImage = UIImage(systemName: "heart")
//        
//        let iconConfig = UIImage.SymbolConfiguration(pointSize: 4, weight: .regular)
//        let resizedIcon = heartImage?.withConfiguration(iconConfig)
//        configuration.image = resizedIcon
//        
//        let button = UIButton(configuration: configuration)
//        button.backgroundColor = .lightGray.withAlphaComponent(0.5)
//        button.layer.cornerRadius = 12
//        
//        return button
        let button = UIButton()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 15, weight: .light)
        let image = UIImage(systemName: "heart", withConfiguration: imageConfig)
        
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 12
        button.backgroundColor = .lightGray.withAlphaComponent(0.5)
        button.addTarget(self, action: #selector(goodButtonTapped), for: .touchUpInside)
        button.isUserInteractionEnabled = true
        
        return button
    }()
    
    private let productLabel: UILabel = {
        let object = UILabel()
        object.font = .systemFont(ofSize: 12)
        object.numberOfLines = 2
        return object
    }()
    
    private let priceLabel: UILabel = {
        let object = UILabel()
        object.font = .boldSystemFont(ofSize: 14)
        return object
    }()
    
    weak var delegate: SearchResultCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    override func configureHierarchy() {
        contentView.addSubview(productImage)
        contentView.addSubview(likeButton)
        contentView.addSubview(productLabel)
        contentView.addSubview(priceLabel)
    }
    
    override func configureLayout() {
        productImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(productImage.snp.width).multipliedBy(1.2)
        }
        
        likeButton.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(10)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.size.equalTo(24)
        }
        
        productLabel.snp.makeConstraints { make in
            make.top.equalTo(productImage.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(4)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(productLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(4)
            make.height.equalTo(16)
        }
    }
    
    @objc private func goodButtonTapped() {
        if let delegate = delegate {
            print("here")
            delegate.goodButtonTapped(at: likeButton.tag)
        }
    }
    
    func designCell(transition: SearchResultDetail, index: Int) {
        productImage.setImage(transition.image)
        likeButton.tag = index
        likeButton.setImage(UserDefaults.standard.bool(forKey: transition.productId) ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart"), for: .normal)
        likeButton.tintColor = UserDefaults.standard.bool(forKey: transition.productId) ? UIColor.red : UIColor.white
        
        productLabel.text = HTMLManager.shared.changeHTML(text: transition.title)
        priceLabel.text = "\(NumberFormatterManager.shared.Comma(Int(transition.lprice) ?? 0))원"
    }
}
