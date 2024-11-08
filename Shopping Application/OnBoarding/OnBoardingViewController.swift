//
//  OnBoardingViewController.swift
//  Shopping Application
//
//  Created by 김성률 on 6/13/24.
//

import UIKit
import SnapKit

final class OnBoardingViewController: BaseViewController {
    
    private let titleLabel: UILabel = {
        let object = UILabel()
        object.text = "MeaningOut"
        object.textColor = CustomDesign.orange
        object.font = .systemFont(ofSize: 40, weight: .heavy)
        object.textAlignment = .center
        return object
    }()
    
    private let launchImage: UIImageView = {
        let object = UIImageView()
        object.image = UIImage(named: "launch")
        return object
    }()
    
    private let startButton: UIButton = {
        let object = UIButton()
        object.setTitle("시작하기", for: .normal)
        object.titleLabel?.font = .boldSystemFont(ofSize: 15)
        object.setTitleColor(.white, for: .normal)
        object.backgroundColor = CustomDesign.orange
        object.layer.cornerRadius = 20
        return object
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaultsManager.mode = ProfileMode.setup.rawValue
    }
    
    override func configureHierarchy() {
        [titleLabel, launchImage, startButton].forEach {
            view.addSubview($0)
        }
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(90)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
        
        launchImage.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(80)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.height.equalTo(240)
        }
        
        startButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
    }
    
    override func configureAction() {
        startButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
    }
    
    @objc func startButtonClicked() {
        transitionScreen(vc: ProfileSettingViewController(), style: .push)
    }
}
