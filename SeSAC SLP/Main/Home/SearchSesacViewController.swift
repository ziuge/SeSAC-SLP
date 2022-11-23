//
//  SearchSesacViewController.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/11/23.
//

import UIKit

class SearchSesacViewController: BaseViewController {
    
    let tagList: [String] = [
        "Choi",
        "SnapKit",
        "RxSwift",
        "Swift",
        "UIKit",
        "Foundation"
      ]
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
//        layout.minimumLineSpacing = 10
//        layout.scrollDirection = .vertical
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
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
//        collectionView.register(SearchSesacCollectionViewCell.self, forCellWithReuseIdentifier: SearchSesacCollectionViewCell.reuseIdentifier)
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
            content.textProperties.color = Constants.Color.error
            content.textProperties.font = Constants.Font.title4!
            cell.contentConfiguration = content
        }
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(84), heightDimension: .estimated(32))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.edgeSpacing = .init(leading: .fixed(8), top: .fixed(8), trailing: .fixed(8), bottom: .fixed(8))
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(32))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = tagList[indexPath.item]
        let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
//        cell.label.text = tagList[indexPath.row]
//        cell.label.font = Constants.Font.title4
//        cell.label.textColor = Constants.Color.gray3
        cell.layer.borderWidth = 1
        cell.layer.borderColor = Constants.Color.error.cgColor
        cell.layer.cornerRadius = 5
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return tagList.count
        } else {
            return 0
        }
        
    }
    
    

}

//class SearchSesacCollectionViewCell: BaseCollectionViewCell {
//
//    let label: UILabel = {
//        let view = UILabel()
//
//        return view
//    }()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//
//    override func setConstraints() {
//        contentView.addSubview(label)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//
//}
