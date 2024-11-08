//
//  MainSettingViewController.swift
//  Shopping Application
//
//  Created by 김성률 on 6/14/24.
//

import UIKit
import SnapKit
import RealmSwift

final class MainSettingViewController: BaseViewController {

    let settingTableView = UITableView()
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        settingTableView.delegate = self
        settingTableView.dataSource = self
        settingTableView.register(SettingProfileTableViewCell.self, forCellReuseIdentifier: SettingProfileTableViewCell.identifier)
        settingTableView.register(SettingOtherTableViewCell.self, forCellReuseIdentifier: SettingOtherTableViewCell.identifier)
        
        NotificationCenter.default.addObserver(self, selector: #selector(receivedNotification), name: NSNotification.Name("update"), object: nil)
    }
    
    override func configureHierarchy() {
        view.addSubview(settingTableView)
    }
    
    override func configureLayout() {
        settingTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureUI() {
        navigationItem.title = "SETTING"
    }
    
    @objc func receivedNotification(notification: NSNotification) {
        settingTableView.reloadData()
    }
}

extension MainSettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ConstantTable.settingCell.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            guard let cell = settingTableView.dequeueReusableCell(withIdentifier: SettingProfileTableViewCell.identifier, for: indexPath) as? SettingProfileTableViewCell else { return UITableViewCell() }
            
            cell.profileImage.image = UIImage(named: "profile_\(UserInfo.shared.profileNumber)")
            cell.profileName.text = UserInfo.shared.userName
            
            return cell

        } else {
            
            guard let cell = settingTableView.dequeueReusableCell(withIdentifier: SettingOtherTableViewCell.identifier, for: indexPath) as? SettingOtherTableViewCell else { return UITableViewCell() }
            
            var task: Results<DBTable> = realm.objects(DBTable.self)
            
            if indexPath.row == 1 {
                cell.saveImage.image = CustomDesign.likeImage
                cell.countLabel.text = "\(task.count)개의 상품"
            } else {
                cell.saveImage.image = nil
                cell.countLabel.text = nil
            }
            
            if indexPath.row == 5 {
                cell.isUserInteractionEnabled = true
            } else {
                cell.isUserInteractionEnabled = false
            }
            
            cell.designCell(transition: ConstantTable.settingCell[indexPath.row - 1])
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 120
        } else {
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
            transitionScreen(vc: ProfileSettingViewController(), style: .push)
            
        } else if indexPath.row == 5 {
            
            if let appDomain = Bundle.main.bundleIdentifier {
                UserDefaults.standard.removePersistentDomain(forName: appDomain)
            }
            
            showAlert(title: "탈퇴하기", message: "탈퇴를 하면 데이터가 모두 초기화됩니다. 탈퇴 하시겠습니까?", completionHandler: initialize)
        }
    }
}

extension MainSettingViewController {
    
    private func initialize() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        let rootViewcontroller = UINavigationController(rootViewController: OnBoardingViewController())
        
        sceneDelegate?.window?.rootViewController = rootViewcontroller
        sceneDelegate?.window?.makeKeyAndVisible()
    }
}
