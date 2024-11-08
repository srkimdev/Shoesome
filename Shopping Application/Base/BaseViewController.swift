//
//  BaseViewController.swift
//  Shopping Application
//
//  Created by 김성률 on 6/26/24.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureUI()
        configureAction()
        bind()
        
        view.backgroundColor = .white
    }
    
    func configureHierarchy() { }
    
    func configureLayout() { }
    
    func configureUI() { }
    
    func configureAction() { }
    
    func bind() { }
    
}
