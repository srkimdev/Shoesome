//
//  ShowShoesViewController.swift
//  Shopping Application
//
//  Created by 김성률 on 10/20/24.
//

import UIKit
import SnapKit

final class ShowShoesViewController: BaseViewController {
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable>!
    private let viewModel = ShowShoesViewModel()
    
    private let backgroundBlack = {
        let object = UIView()
        object.backgroundColor = .black
        object.layer.cornerRadius = 20
        return object
    }()
    
    private let mainTitle = {
        let object = UILabel()
        object.text = "Shoes Collection"
        object.textColor = .white
        object.font = .systemFont(ofSize: 35, weight: .bold)
        return object
    }()
    
    private lazy var mainCollectionView: UICollectionView = {
        let object = UICollectionView(frame: .zero, collectionViewLayout: compositionalLayout())
        object.register(MainCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MainCollectionHeaderView.identifier)
        object.backgroundColor = .clear
        return object
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bind()
        configureDataSource()
        viewModel.inputTrigger.value = ()
    }
    
    override func configureHierarchy() {
        view.addSubview(backgroundBlack)
        view.addSubview(mainTitle)
        view.addSubview(mainCollectionView)
    }
    
    override func configureLayout() {
        backgroundBlack.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.4)
        }
        
        mainTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }

        mainCollectionView.snp.makeConstraints { make in
            make.top.equalTo(mainTitle.snp.bottom).offset(16)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func bind() {
        viewModel.outputComplete.bind { value in
            self.updateSnapshot()
        }
    }
    
    private func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
        snapshot.appendSections(Section.allCases)
        
        snapshot.appendItems(BrandCategory.allCases, toSection: .categories)
        snapshot.appendItems(viewModel.outputBrandList.value, toSection: .brands)
        snapshot.appendItems(viewModel.outputNewList.value, toSection: .recents)
        
        dataSource.apply(snapshot)
    }
    
    private func categoryCellRegistration() -> UICollectionView.CellRegistration<CategoryCollectionViewCell, BrandCategory> {
        let result = UICollectionView.CellRegistration<CategoryCollectionViewCell, BrandCategory> { cell, indexPath, itemIdentifier in
            cell.designCell(input: itemIdentifier.rawValue)
        }
        
        return result
    }
    
    private func brandCellRegistration() -> UICollectionView.CellRegistration<ProductCollectionViewCell, SearchResultDetail> {
        let result = UICollectionView.CellRegistration<ProductCollectionViewCell, SearchResultDetail> { cell, indexPath, itemIdentifier in
            cell.designCell(item: itemIdentifier)
        }
        
        return result
    }
    
    private func recentCellRegistration() -> UICollectionView.CellRegistration<RecentProductCollectionViewCell, SearchResultDetail> {
        let result = UICollectionView.CellRegistration<RecentProductCollectionViewCell, SearchResultDetail> { cell, indexPath, itemIdentifier in
            cell.designCell(item: itemIdentifier)
        }
        
        return result
    }
    
    private func configureDataSource() {
        let categoryCellRegistration = categoryCellRegistration()
        let brandCellRegistration = brandCellRegistration()
        let recentCellRegistration = recentCellRegistration()
        
        dataSource = UICollectionViewDiffableDataSource<Section, AnyHashable>(collectionView: mainCollectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: AnyHashable) -> UICollectionViewCell? in

            let section = Section(rawValue: indexPath.section)
            
            switch section {
                case .categories:
                return collectionView.dequeueConfiguredReusableCell(using: categoryCellRegistration, for: indexPath, item: identifier as? BrandCategory)
                case .brands:
                return collectionView.dequeueConfiguredReusableCell(using: brandCellRegistration, for: indexPath, item: identifier as? SearchResultDetail)
                case .recents:
                return collectionView.dequeueConfiguredReusableCell(using: recentCellRegistration, for: indexPath, item: identifier as? SearchResultDetail)
                default:
                    return nil
                }
        }
        
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionHeader else { return nil }
                
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MainCollectionHeaderView.identifier, for: indexPath) as! MainCollectionHeaderView
            
            if indexPath.section == 2 {
                header.titleLabel.text = "신상"
            }
            
            return header
        }
        
    }

}

extension ShowShoesViewController {
    
    enum Section: Int, CaseIterable {
        case categories
        case brands
        case recents
    }
    
    func compositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            switch sectionIndex {
            case 0:
                return self.categoryLayout()
            case 1:
                return self.brandLayout()
            case 2:
                return self.recentLayout()
            default:
                return nil
            }
        }
    }
    
    func categoryLayout() -> NSCollectionLayoutSection {
        let fraction: CGFloat = 1
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(100), heightDimension: .fractionalHeight(fraction))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(100), heightDimension: .absolute(50))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 20, bottom: 0, trailing: 20)
        section.interGroupSpacing = 20
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
    
    func brandLayout() -> NSCollectionLayoutSection {
        let fraction: CGFloat = 1
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fraction), heightDimension: .fractionalHeight(fraction))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(3.5/5), heightDimension: .fractionalWidth(3.5/5 * 1.2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 20, bottom: 0, trailing: 20)
        section.interGroupSpacing = 20
        section.orthogonalScrollingBehavior = .continuous
        
        let supplementaryItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(15))
        let supplementaryItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: supplementaryItemSize,
                                                                            elementKind: UICollectionView.elementKindSectionHeader,
                                                                            alignment: .top)
        section.boundarySupplementaryItems = [supplementaryItem]
        
        return section
    }
    
    func recentLayout() -> NSCollectionLayoutSection {
        let fraction: CGFloat = 1
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fraction), heightDimension: .fractionalHeight(fraction))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(100), heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 20, bottom: 0, trailing: 20)
        section.interGroupSpacing = 10
        section.orthogonalScrollingBehavior = .continuous
        
        let supplementaryItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(60))
        let supplementaryItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: supplementaryItemSize,
                                                                            elementKind: UICollectionView.elementKindSectionHeader,
                                                                            alignment: .top)
        section.boundarySupplementaryItems = [supplementaryItem]
        
        return section
    }
    
}
