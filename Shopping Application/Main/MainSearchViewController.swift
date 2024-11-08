//
//  MainSearchViewController.swift
//  Shopping Application
//
//  Created by 김성률 on 6/14/24.
//

import UIKit
import SnapKit

final class MainSearchViewController: BaseViewController {

    private lazy var searchBar: UISearchBar = {
        let object = UISearchBar()
        object.delegate = self
        object.placeholder = "브랜드, 상품 등을 입력하세요."
        object.searchBarStyle = .minimal
        return object
    }()
    
    private let searchBarLine: UIView = {
        let object = UIView()
        object.backgroundColor = CustomDesign.lineColor
        return object
    }()
    
    private let noRecentImage: UIImageView = {
        let object = UIImageView()
        object.image = UIImage(named: "empty")
        return object
    }()
    
    private let noRecentLabel: UILabel = {
        let object = UILabel()
        object.text = "최근 검색어가 없어요"
        object.font = .boldSystemFont(ofSize: 15)
        object.textAlignment = .center
        return object
    }()
    
    private let recentLabel: UILabel = {
        let object = UILabel()
        object.text = "최근 검색"
        object.font = .boldSystemFont(ofSize: 14)
        return object
    }()
    
    private let deleteAllButton: UIButton = {
        let object = UIButton()
        object.setTitle("전체 삭제", for: .normal)
        object.setTitleColor(CustomDesign.orange, for: .normal)
        object.titleLabel?.font = .systemFont(ofSize: 14)
        return object
    }()
    
    private lazy var searchListTableView: UITableView = {
        let object = UITableView()
        object.delegate = self
        object.dataSource = self
        object.register(MainSearchTableViewCell.self, forCellReuseIdentifier: MainSearchTableViewCell.identifier)
        object.rowHeight = 40
        object.separatorStyle = .none
        return object
    }()
    
    private let viewModel = MainSearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(receivedNotification), name: NSNotification.Name("update"), object: nil)
    }

    override func configureHierarchy() {
        view.addSubview(searchBar)
        view.addSubview(searchBarLine)
        view.addSubview(noRecentImage)
        view.addSubview(noRecentLabel)
        view.addSubview(recentLabel)
        view.addSubview(deleteAllButton)
        view.addSubview(searchListTableView)
    }
    
    override func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.height.equalTo(44)
        }
        
        searchBarLine.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(4)
            make.height.equalTo(1)
        }
        
        noRecentImage.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(230)
            make.width.equalTo(280)
        }
        
        noRecentLabel.snp.makeConstraints { make in
            make.top.equalTo(noRecentImage.snp.bottom)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(30)
        }
        
        recentLabel.snp.makeConstraints { make in
            make.top.equalTo(searchBarLine.snp.bottom).offset(8)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.height.equalTo(30)
        }
        
        deleteAllButton.snp.makeConstraints { make in
            make.top.equalTo(searchBarLine.snp.bottom).offset(12)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
            make.height.equalTo(30)
        }
        
        searchListTableView.snp.makeConstraints { make in
            make.top.equalTo(recentLabel.snp.bottom)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func bind() {
        viewModel.reloadDataTrigger
            .bind { [weak self] _ in
                guard let self else { return }
                searchListTableView.reloadData()
            }
    }
    
    override func configureUI() {
        navigationItem.title = "\(UserInfo.shared.userName)'s MEANING OUT"
    }
    
    override func configureAction() {
        deleteAllButton.addTarget(self, action: #selector(deleteAllButtonClicked), for: .touchUpInside)
    }

    @objc func deleteButtonClicked(sender: UIButton) {
        viewModel.deleteButtonTapped.value = sender.tag
    }

    @objc func deleteAllButtonClicked() {
        viewModel.deleteAllButtonTapped.value = ()
    }

    @objc func receivedNotification(notification: NSNotification) {
        navigationItem.title = "\(UserInfo.shared.userName)'s MEANING OUT"
    }
}

extension MainSearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if !NetworkConnectManager.shared.isNetworkAvailable() {
            view.endEditing(true)
            NetworkConnectManager.shared.showToast(message: "인터넷에 연결되지 않았습니다.\n연결 확인 후 다시 시도해 주세요.")
            return
        }
        
        guard let text = searchBar.text, !text.contains(" ") else {
            showAlertOnlyForCheck(title: "검색어를 입력해주세요.")
            searchBar.text = nil
            return
        }
        
        searchBar.text = nil
        viewModel.inputText.value = text
        
        let vc = SearchResultViewController(SearchResultViewModel(searchText: text))
        transitionScreen(vc: vc, style: .push)
    }
}

extension MainSearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.searchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = searchListTableView.dequeueReusableCell(withIdentifier: MainSearchTableViewCell.identifier, for: indexPath) as? MainSearchTableViewCell else { return UITableViewCell() }
        
        cell.designCell(transition: viewModel.searchList[indexPath.row])
        cell.deleteButton.tag = indexPath.row
        cell.deleteButton.addTarget(self, action: #selector(deleteButtonClicked), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if !NetworkConnectManager.shared.isNetworkAvailable() {
            NetworkConnectManager.shared.showToast(message: "인터넷에 연결되지 않았습니다.\n연결 확인 후 다시 시도해 주세요.")
            return
        }
        
        let vc = SearchResultViewController(SearchResultViewModel(searchText: viewModel.searchList[indexPath.row]))
        transitionScreen(vc: vc, style: .push)
    }
}

