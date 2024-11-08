//
//  ProfileSelectingViewController.swift
//  Shopping Application
//
//  Created by 김성률 on 6/14/24.
//

import UIKit
import SnapKit

final class ProfileSelectingViewController: BaseViewController {

    let selectedImage = UIImageView()
    let selectedImageButton = UIButton()
    let cameraImageView = UIImageView()
    let cameraImage = UIImageView()
    
    lazy var imageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    var selectedNumber: ((Int) -> Void)?
    var profileImageNumber: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.register(ProfileSelectingCollectionViewCell.self, forCellWithReuseIdentifier: ProfileSelectingCollectionViewCell.identifier)
    }

    override func viewDidLayoutSubviews() {
        selectedImage.layer.cornerRadius = selectedImage.frame.width / 2
        cameraImageView.layer.cornerRadius = 10
    }
    
    override func configureHierarchy() {
        view.addSubview(selectedImage)
        view.addSubview(selectedImageButton)
        selectedImageButton.addSubview(cameraImageView)
        cameraImageView.addSubview(cameraImage)
        view.addSubview(imageCollectionView)
    }
    
    override func configureLayout() {
        
        selectedImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalTo(view.self)
            make.size.equalTo(100)
        }
        
        selectedImageButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalTo(view.self)
            make.size.equalTo(100)
        }
        
        cameraImageView.snp.makeConstraints { make in
            make.trailing.equalTo(selectedImageButton.snp.trailing).inset(4)
            make.bottom.equalTo(selectedImageButton.snp.bottom).inset(12)
            make.size.equalTo(20)
        }
        
        cameraImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(cameraImageView.snp.width).multipliedBy(0.7)
        }
        
        imageCollectionView.snp.makeConstraints { make in
            make.top.equalTo(selectedImage.snp.bottom).offset(60)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(300)
        }
    }
    
    override func configureUI() {
        
        navigationItem.title = UserDefaultsManager.mode == ProfileMode.edit.rawValue ? "EDIT PROFILE" : "PROFILE SETTING"
        
        selectedImage.image = UIImage(named: "profile_\(profileImageNumber)")
        
        BackButton()

        selectedImage.layer.masksToBounds = true
        selectedImage.layer.borderWidth = CustomDesign.profileBorderWidth3
        selectedImage.layer.borderColor = CustomDesign.orange.cgColor
        
        cameraImageView.backgroundColor = CustomDesign.orange
        
        cameraImage.tintColor = .white
        cameraImage.image = UIImage(systemName: "camera.fill")
    }
}

extension ProfileSelectingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ConstantTable.profileImageNumber.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: ProfileSelectingCollectionViewCell.identifier, for: indexPath) as? ProfileSelectingCollectionViewCell else { return UICollectionViewCell() }
        
        cell.designCell(transition: indexPath.item, num: profileImageNumber)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        profileImageNumber = indexPath.item
        selectedImage.image = UIImage(named: "profile_\(profileImageNumber)")
        
        selectedNumber?(profileImageNumber)
        
        imageCollectionView.reloadData()
    }
}

extension ProfileSelectingViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width - 70
        
        layout.itemSize = CGSize(width: width/4, height: width/4)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        return layout
    }
}
