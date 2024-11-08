//
//  SearchSaveViewController.swift
//  Shopping Application
//
//  Created by 김성률 on 7/7/24.
//

import UIKit
import SnapKit

final class SearchSaveViewController: BaseViewController {

    private var dataSource: UICollectionViewDiffableDataSource<Section, SearchResultDetail>!
    
    private lazy var productCollectionView: UICollectionView = {
        let object = UICollectionView(frame: .zero, collectionViewLayout: saveLayout())
        object.register(SearchSaveCollectionViewCell.self, forCellWithReuseIdentifier: SearchSaveCollectionViewCell.identifier)
        return object
    }()
    
    private let totalLabel = {
        let object = UILabel()
        object.text = "Total"
        object.font = .systemFont(ofSize: 20, weight: .bold)
        return object
    }()
    
    private let totalPrice = {
        let object = UILabel()
        object.font = .systemFont(ofSize: 20, weight: .bold)
        return object
    }()
    
    private let viewModel = SearchSaveViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureDataSource()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.inputTrigger.value = ()
    }

    override func configureHierarchy() {
        view.addSubview(productCollectionView)
        view.addSubview(totalLabel)
        view.addSubview(totalPrice)
    }
    
    override func configureLayout() {
        productCollectionView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(totalLabel.snp.top)
        }
        
        totalLabel.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.height.equalTo(30)
        }
        
        totalPrice.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(30)
        }
    }
    
    override func configureUI() {
        navigationItem.title = "Cart"
    }
    
    private func updateSnapshot(_ item: [SearchResultDetail]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, SearchResultDetail>()
        snapshot.appendSections(Section.allCases)
        
        snapshot.appendItems(item, toSection: .main)
        
        dataSource.apply(snapshot)
    }
    
    private func mainCellRegistration() -> UICollectionView.CellRegistration<SearchSaveCollectionViewCell, SearchResultDetail> {
        let result = UICollectionView.CellRegistration<SearchSaveCollectionViewCell, SearchResultDetail> { cell, indexPath, itemIdentifier in
            cell.designCell(itemIdentifier)
        }
        
        return result
    }
    
    private func configureDataSource() {
        let mainCellRegistration = mainCellRegistration()
        
        dataSource = UICollectionViewDiffableDataSource<Section, SearchResultDetail>(collectionView: productCollectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: SearchResultDetail) -> UICollectionViewCell? in
            
            return collectionView.dequeueConfiguredReusableCell(using: mainCellRegistration, for: indexPath, item: identifier)
        }
    }
    
    @objc func likeButtonClicked(sender: UIButton) {

//        let filter = realm.objects(DBTable.self).first(where: {$0.productId == list[sender.tag].productId} )
//        UserInfo.shared.setLikeProduct(isLike: false, forkey: list[sender.tag].productId)
//        
//        viewModel.inputUnLike.value = filter!
//        list.remove(at: sender.tag)

        UIView.performWithoutAnimation {
            productCollectionView.reloadData()
        }
    }
    
    override func bind() {
        viewModel.outputResult.bind { [weak self] value in
            guard let self else { return }
            updateSnapshot(value)
        }
        
        viewModel.outputPrice
            .bind { [weak self] value in
                guard let self else { return }
                totalPrice.text = "₩" + NumberFormatterManager.shared.Comma(value)
            }
    }
}

extension SearchSaveViewController {
    enum Section: Int, CaseIterable {
        case main
    }

    func saveLayout() -> UICollectionViewLayout {
        let fraction: CGFloat = 1
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fraction), heightDimension: .fractionalHeight(fraction))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 20, bottom: 0, trailing: 20)
        section.interGroupSpacing = 20
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}

