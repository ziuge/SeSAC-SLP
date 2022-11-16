//
//  MypageViewController.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/11/15.
//

import UIKit

struct MyPage: Hashable {
    let name: String
    let image: UIImage?
}

class MypageViewController: BaseViewController {
    // MARK: UI
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    
    var list = [
        MyPage(name: "김새싹", image: UIImage(named: "sesac_face_1 1")),
        MyPage(name: "공지사항", image: UIImage(named: "notice")),
        MyPage(name: "자주 묻는 질문", image: UIImage(named: "faq")),
        MyPage(name: "1:1 문의", image: UIImage(named: "qna")),
        MyPage(name: "알림 설정", image: UIImage(named: "setting_alarm")),
        MyPage(name: "이용약관", image: UIImage(named: "permit"))
    ]
    
    var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, MyPage>!
    
    var dataSource: UICollectionViewDiffableDataSource<Int, MyPage>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "내정보"
        view.backgroundColor = .systemMint
        
        configureHierarchy()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func configure() {
        view.addSubview(collectionView)
    }
    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalTo(view)
        }
    }
}

extension MypageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func configureHierarchy() {
        collectionView.collectionViewLayout = createLayout()
        
        cellRegistration = UICollectionView.CellRegistration { cell, indexPath, itemIdentifier in // itemIdentifier - 셀 정보
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.name
            
            content.image = itemIdentifier.image
            content.imageProperties.tintColor = .yellow
            cell.contentConfiguration = content
        }
    }
    
    private func createLayout() -> UICollectionViewLayout {
//        var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
//        configuration.showsSeparators = true
//
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .absolute(74))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize,
                                                       subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 5
        section.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                                leading: 5,
                                                                bottom: 5,
                                                                trailing: 5)

        let layout = UICollectionViewCompositionalLayout(section: section)
//        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = list[indexPath.item]
        let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = MypageSettingViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
