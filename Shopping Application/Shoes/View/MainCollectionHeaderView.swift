//
//  MainCollectionHeaderView.swift
//  Shopping Application
//
//  Created by 김성률 on 10/21/24.
//

import UIKit
import SnapKit

final class MainCollectionHeaderView: UICollectionReusableView {
    
    let titleLabel = {
        let object = UILabel()
        object.font = .systemFont(ofSize: 20, weight: .bold)
        return object
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
        addSubview(titleLabel)
    }
    
    func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
}
