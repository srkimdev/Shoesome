//
//  SearchDetailViewController.swift
//  Shopping Application
//
//  Created by 김성률 on 10/25/24.
//

import UIKit
import SnapKit

final class SearchDetailViewController: BaseViewController {
    
    var productData: SearchResultDetail?
    
    private let productImage = {
        let object = UIImageView()
        return object
    }()
    
    private let xButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.baseForegroundColor = .black
        configuration.baseBackgroundColor = .clear
        
        let heartImage = UIImage(systemName: "xmark")
        
        let iconConfig = UIImage.SymbolConfiguration(pointSize: 16, weight: .regular)
        let resizedIcon = heartImage?.withConfiguration(iconConfig)
        configuration.image = resizedIcon

        configuration.imagePadding = 8
        
        let button = UIButton(configuration: configuration)
        
        return button
    }()
    
    private let companyLabel = {
        let object = UILabel()
        return object
    }()
    
    private let likeButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.baseForegroundColor = .red
        configuration.baseBackgroundColor = .clear
        
        let heartImage = UIImage(systemName: "heart.fill")
        
        let iconConfig = UIImage.SymbolConfiguration(pointSize: 16, weight: .regular)
        let resizedIcon = heartImage?.withConfiguration(iconConfig)
        configuration.image = resizedIcon

        configuration.imagePadding = 8
        
        let button = UIButton(configuration: configuration)
        
        return button
    }()
    
    private let productLabel = {
        let object = UILabel()
        object.numberOfLines = 2
        object.font = .systemFont(ofSize: 20)
        return object
    }()
    
    private let line = {
        let object = UIView()
        object.backgroundColor = CustomDesign.lineColor
        return object
    }()
    
    private let categoryLabel = {
        let object = UILabel()
        object.font = .systemFont(ofSize: 14)
        object.textColor = .gray
        return object
    }()
    
    private let priceLabel = {
        let object = UILabel()
        object.font = .systemFont(ofSize: 20, weight: .bold)
        return object
    }()
    
    private let addButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.baseForegroundColor = .white
        configuration.baseBackgroundColor = .darkGray
        
        var attText = AttributedString("Add to Cart")
        attText.font = UIFont.systemFont(ofSize: 18)
        configuration.attributedTitle = attText
        
        let button = UIButton(configuration: configuration)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configureHierarchy() {
        view.addSubview(productImage)
        productImage.addSubview(xButton)
        view.addSubview(companyLabel)
        view.addSubview(likeButton)
        view.addSubview(line)
        view.addSubview(categoryLabel)
        view.addSubview(productLabel)
        view.addSubview(priceLabel)
        view.addSubview(addButton)
    }
    
    override func configureLayout() {
        productImage.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(productImage.snp.width).multipliedBy(1.2)
        }
        
        xButton.snp.makeConstraints { make in
            make.top.equalTo(productImage.snp.top).offset(16)
            make.trailing.equalTo(productImage.snp.trailing).inset(16)
            make.size.equalTo(24)
        }
        
        companyLabel.snp.makeConstraints { make in
            make.top.equalTo(productImage.snp.bottom)
            make.height.equalTo(60)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        likeButton.snp.makeConstraints { make in
            make.centerY.equalTo(companyLabel)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.size.equalTo(24)
        }
        
        line.snp.makeConstraints { make in
            make.top.equalTo(companyLabel.snp.bottom)
            make.horizontalEdges.equalTo(16)
            make.height.equalTo(1)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(line.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        productLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        addButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(50)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.bottom.equalTo(addButton.snp.top).offset(-16)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(30)
        }
    }
    
    override func configureUI() {
        guard let productData else { return }
        
        productImage.setImage(productData.image)
        companyLabel.text = productData.mallName
        categoryLabel.text = productData.category1 + " > " + productData.category2 + " > " + productData.category3
        
        productLabel.text = HTMLManager.shared.changeHTML(text: productData.title)
        
        priceLabel.text = "₩" + NumberFormatterManager.shared.Comma(Int(productData.lprice) ?? 0)
        priceLabel.textAlignment = .right
    }
    
}
