//
//  SettingProfileTableViewCell.swift
//  Shopping Application
//
//  Created by 김성률 on 6/15/24.
//

import UIKit
import SnapKit

final class SettingProfileTableViewCell: BaseTableViewCell {

    let profileImage = UIImageView()
    let profileName = UILabel()
    let joinDate = UILabel()
    let nextButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
    }
    
    override func configureHierarchy() {
        [profileImage, profileName, joinDate, nextButton].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        
        profileImage.snp.makeConstraints { make in
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(20)
            make.verticalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(24)
            make.width.equalTo(profileImage.snp.height)
        }
        
        profileName.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(40)
            make.leading.equalTo(profileImage.snp.trailing).offset(20)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(20)
        }
        
        joinDate.snp.makeConstraints { make in
            make.top.equalTo(profileName.snp.bottom).offset(8)
            make.leading.equalTo(profileImage.snp.trailing).offset(20)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(12)
        }
        
        nextButton.snp.makeConstraints { make in
            make.verticalEdges.equalTo(contentView.safeAreaLayoutGuide)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(16)
        }
        
    }
    
    override func configureUI() {
        
        profileImage.layer.masksToBounds = true
        profileImage.layer.borderWidth = CustomDesign.profileBorderWidth3
        profileImage.layer.borderColor = CustomDesign.orange.cgColor
        
        profileName.font = .boldSystemFont(ofSize: 17)
        
        joinDate.text = "\(UserInfo.shared.joinDate) 가입"
        joinDate.font = .systemFont(ofSize: 12)
        
        nextButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        nextButton.tintColor = .gray
    }
}

