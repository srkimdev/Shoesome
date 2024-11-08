//
//  SettingOtherTableViewCell.swift
//  Shopping Application
//
//  Created by 김성률 on 6/15/24.
//

import UIKit
import SnapKit

final class SettingOtherTableViewCell: BaseTableViewCell {

    let listLabel = UILabel()
    let saveImage = UIImageView()
    let countLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }

    override func configureHierarchy() {
        [listLabel, saveImage, countLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        
        listLabel.snp.makeConstraints { make in
            make.verticalEdges.equalTo(contentView.safeAreaLayoutGuide)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).inset(20)
        }
        
        countLabel.snp.makeConstraints { make in
            make.verticalEdges.equalTo(contentView.safeAreaLayoutGuide)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(20)
        }
        
        saveImage.snp.makeConstraints { make in
            make.verticalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.trailing.equalTo(countLabel.snp.leading).offset(-4)
        }
    }
    
    override func configureUI() {
        listLabel.font = .systemFont(ofSize: 13)
        countLabel.font = .systemFont(ofSize: 13)
    }
    
    func designCell(transition: String) {
        listLabel.text = transition
    }
}
