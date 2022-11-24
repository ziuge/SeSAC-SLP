//
//  SearchSesacViewController.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/11/23.
//

import UIKit

class SearchSesacViewController: BaseViewController {
    
    var tagList: [String] = [
        "Choi",
        "SnapKit",
        "RxSwift",
        "Swift",
        "UIKit",
        "Foundation"
      ]
    var studyQueueList: [String] = []
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    
    var cellRegistration: UICollectionView.CellRegistration<UICollectionViewCell, String>!
    var dataSource: UICollectionViewDiffableDataSource<Int, String>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemMint
        
        let searchBar = UISearchBar()
        searchBar.placeholder = "띄어쓰기로 복수 입력이 가능해요"
        self.navigationItem.titleView = searchBar
        
        configureHierarchy()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        print("tag List:", tagList)
        print("studyQueueList", studyQueueList)
    }
    
    override func configure() {
        [collectionView].forEach {
            view.addSubview($0)
        }
    }
    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}

extension SearchSesacViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func configureHierarchy() {
        collectionView.collectionViewLayout = createLayout()
        cellRegistration = UICollectionView.CellRegistration { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.cell()
            content.text = itemIdentifier
            if indexPath.section == 0 {
                content.textProperties.color = Constants.Color.error
                cell.layer.borderColor = Constants.Color.error.cgColor
            } else {
                content.textProperties.color = Constants.Color.black
                cell.layer.borderColor = Constants.Color.gray3.cgColor
            }
            
            content.textProperties.font = Constants.Font.title4!
            
            cell.contentConfiguration = content
        }
        collectionView.register(UINib(nibName: "HeaderSupplementaryView", bundle: nil), forSupplementaryViewOfKind: "header", withReuseIdentifier: "HeaderSupplementaryView")
    }
    
    private func createLayout() -> UICollectionViewLayout {
        
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            
            switch sectionNumber {
                
            case 0: return self.firstLayoutSection()
            case 1: return self.secondLayoutSection()
            default: return self.firstLayoutSection()
            }
        }
        
//        let layout = UICollectionViewCompositionalLayout(section: section)
//        return layout
    }
    
    private func firstLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(40), heightDimension: .estimated(20))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.edgeSpacing = .init(leading: .fixed(8), top: .fixed(8), trailing: .fixed(8), bottom: .fixed(0))
        item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(20))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        
//        let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
//                                                     heightDimension: .estimated(44))
//        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
//            layoutSize: headerFooterSize,
//            elementKind: SearchSesacViewController.sectionHeaderElementKind, alignment: .top)
//        let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(
//            layoutSize: headerFooterSize,
//            elementKind: SearchSesacViewController.sectionFooterElementKind, alignment: .bottom)
//        section.boundarySupplementaryItems = [sectionHeader, sectionFooter]

        let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(44))
        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize, elementKind: "header", alignment: .top)
        section.boundarySupplementaryItems = [headerItem]
        
        return section
    }
    
    private func secondLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(20), heightDimension: .estimated(20))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.edgeSpacing = .init(leading: .fixed(8), top: .fixed(8), trailing: .fixed(8), bottom: .fixed(0))
        item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(20))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)

        let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(20))
        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize, elementKind: "header", alignment: .top)
        section.boundarySupplementaryItems = [headerItem]
        
        return section
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let item = (indexPath.section == 0) ? tagList[indexPath.item] : studyQueueList[indexPath.item]
        let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        cell.layer.borderWidth = 1.5
        cell.layer.cornerRadius = 10
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return tagList.count
        case 1:
            return studyQueueList.count
        default:
            return 5
        }
    }
    
}
