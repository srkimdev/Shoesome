//
//  ProfileSelectingCollectionViewCell.swift
//  Shopping Application
//
//  Created by 김성률 on 6/14/24.
//

import UIKit
import SnapKit

final class ProfileSelectingCollectionViewCell: BaseCollectionViewCell {
    
    let profileImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
    }
    
    override func configureHierarchy() {
        contentView.addSubview(profileImage)
    }
    
    override func configureLayout() {
        profileImage.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
    
    override func configureUI() {
        profileImage.layer.masksToBounds = true
        profileImage.layer.borderWidth = CustomDesign.profileBorderWidth1
        profileImage.contentMode = .scaleAspectFill
        profileImage.alpha = 0.5
    }
    
    func designCell(transition: Int, num: Int) {
        profileImage.image = UIImage(named: "profile_\(transition)")
        
        if transition == num {
            profileImage.layer.borderColor = CustomDesign.orange.cgColor
            profileImage.alpha = 1
        } else {
            profileImage.layer.borderColor = UIColor.black.cgColor
            profileImage.alpha = 0.5
        }
    }
    
}
