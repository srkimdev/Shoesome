//
//  ProfileSettingViewController.swift
//  Shopping Application
//
//  Created by 김성률 on 6/13/24.
//

import UIKit
import SnapKit

final class ProfileSettingViewController: BaseViewController {

    let profileImage = UIImageView()
    let profileImageButton = UIButton()
    let cameraImageView = UIImageView()
    let cameraImage = UIImageView()
    let nicknameTextField = UITextField()
    let textFieldLine = UIView()
    let nicknameStatusLable = UILabel()
    let clearButton = UIButton()

    let viewModel = ProfileSettingViewModel()
    
    var allowed: Bool = false
    
    var profileImageNumber: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
    }
    
    override func viewDidLayoutSubviews() {
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        cameraImageView.layer.cornerRadius = 10
    }
    
    override func configureHierarchy() {
        view.addSubview(profileImage)
        view.addSubview(profileImageButton)
        profileImageButton.addSubview(cameraImageView)
        cameraImageView.addSubview(cameraImage)
        view.addSubview(nicknameTextField)
        view.addSubview(textFieldLine)
        view.addSubview(nicknameStatusLable)
        view.addSubview(clearButton)
    }
    
    override func configureLayout() {
        
        profileImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalTo(view.self)
            make.size.equalTo(100)
        }
        
        profileImageButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalTo(view.self)
            make.size.equalTo(100)
        }
        
        cameraImageView.snp.makeConstraints { make in
            make.trailing.equalTo(profileImage.snp.trailing).inset(4)
            make.bottom.equalTo(profileImage.snp.bottom).inset(12)
            make.size.equalTo(20)
        }
        
        cameraImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(cameraImageView.snp.width).multipliedBy(0.7)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(profileImageButton.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(32)
            make.height.equalTo(30)
        }
        
        textFieldLine.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(28)
            make.height.equalTo(1)
        }
        
        nicknameStatusLable.snp.makeConstraints { make in
            make.top.equalTo(textFieldLine.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(32)
            make.height.equalTo(24)
        }
        
        clearButton.snp.makeConstraints { make in
            make.top.equalTo(nicknameStatusLable.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(40)
        }
    }
    
    override func configureUI() {
        
        if UserDefaultsManager.mode == ProfileMode.edit.rawValue {
            navigationItem.title = "EDIT PROFILE"
        
            let item = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClicked))
            item.tintColor = CustomDesign.orange
            navigationItem.rightBarButtonItem = item
            
            clearButton.isHidden = true
            profileImageNumber = UserInfo.shared.profileNumber
        } else {
            navigationItem.title = "PROFILE SETTING"
            randomImage()
        }
        
        BackButton()
        
        profileImage.image = UIImage(named: "profile_\(profileImageNumber)")
        profileImage.layer.borderWidth = CustomDesign.profileBorderWidth3
        profileImage.layer.borderColor = CustomDesign.orange.cgColor
        profileImage.layer.masksToBounds = true
        profileImage.contentMode = .scaleAspectFill
        
        cameraImageView.backgroundColor = CustomDesign.orange
        cameraImageView.layer.masksToBounds = true
        cameraImageView.contentMode = .scaleAspectFill
        
        cameraImage.image = UIImage(systemName: "camera.fill")
        cameraImage.tintColor = .white
        
        nicknameTextField.placeholder = "닉네임을 입력해주세요 :)"
        
        textFieldLine.backgroundColor = .systemGray4
        
        nicknameStatusLable.textColor = CustomDesign.orange
        nicknameStatusLable.font = .boldSystemFont(ofSize: 13)
        
        clearButton.setTitle("완료", for: .normal)
        clearButton.setTitleColor(.white, for: .normal)
        clearButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
        clearButton.layer.masksToBounds = true
        clearButton.layer.cornerRadius = 20
    }
    
    override func configureAction() {
        clearButton.addTarget(self, action: #selector(clearButtonClicked), for: .touchUpInside)
        nicknameTextField.addTarget(self, action: #selector(nicknameChanged), for: .editingChanged)
        profileImageButton.addTarget(self, action: #selector(profileImageButtonClicked), for: .touchUpInside)
    }
    
    @objc func clearButtonClicked() {
        if allowed {
            UserInfo.shared.userName = nicknameTextField.text!
            UserInfo.shared.profileNumber = profileImageNumber
            UserInfo.shared.joinDate = DateFormatterManager.shared.today(Date())
            
            UserDefaultsManager.goToSearch = true
            UserDefaultsManager.mode = ProfileMode.edit.rawValue

            let vc = TabBarController()
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            present(vc, animated: true)
        }
    }
    
    @objc func profileImageButtonClicked() {
        let vc = ProfileSelectingViewController()
        
        vc.selectedNumber = { [weak self] value in
            self?.profileImageNumber = value
            self?.profileImage.image = UIImage(named: "profile_\(self?.profileImageNumber ?? 0)")
        }

        vc.profileImageNumber = profileImageNumber
        
        transitionScreen(vc: vc, style: .push)
    }

    @objc func nicknameChanged() {
        viewModel.inputText.value = nicknameTextField.text
    }

    @objc func saveButtonClicked() {
        if allowed {
            UserInfo.shared.userName = nicknameTextField.text!
            UserInfo.shared.profileNumber = profileImageNumber
            NotificationCenter.default.post(name: NSNotification.Name("update"), object: nil, userInfo: nil)
        }
    }
}

extension ProfileSettingViewController {

    private func randomImage() {
        profileImageNumber = .random(in: 0...ConstantTable.profileImageNumber.count - 1)
    }
    
    private func bindData() {
        viewModel.outputText.bind { [weak self] value in
            self?.nicknameStatusLable.text = value
        }
        
        viewModel.allowed.bind { [weak self] value in
            self?.allowed = value
            self?.clearButton.backgroundColor = value ? CustomDesign.orange : .systemGray4
        }
    }
}
