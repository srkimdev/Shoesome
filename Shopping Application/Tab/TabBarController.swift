//
//  TabBarController.swift
//  Shopping Application
//
//  Created by 김성률 on 6/14/24.
//

import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .black
        
        appearance.stackedLayoutAppearance.selected.iconColor = .white
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        appearance.stackedLayoutAppearance.normal.iconColor = .gray
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.gray]
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        
        let shoes = ShowShoesViewController()
        let nav1 = UINavigationController(rootViewController: shoes)
        nav1.tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house"), tag: 0)
    
        let search = MainSearchViewController()
        let nav2 = UINavigationController(rootViewController: search)
        nav2.tabBarItem = UITabBarItem(title: "검색", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        
        let save = SearchSaveViewController()
        let nav3 = UINavigationController(rootViewController: save)
        nav3.tabBarItem = UITabBarItem(title: "좋아요", image: UIImage(systemName: "heart"), tag: 2)
        
        let setting = MainSettingViewController()
        let nav4 = UINavigationController(rootViewController: setting)
        nav4.tabBarItem = UITabBarItem(title: "설정", image: UIImage(systemName: "person"), tag: 3)
        
        setViewControllers([nav1, nav2, nav3, nav4], animated: true)
    }
}

