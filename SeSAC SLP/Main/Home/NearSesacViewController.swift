//
//  NearSesacViewController.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/11/26.
//

import UIKit

class NearSesacViewController: BaseViewController {
    
    var list = [UserDefaultsManager.userinfo]
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    
    private var cellRegistration: UICollectionView.CellRegistration<UserCollectionViewCell, UserInfo>!
    private var dataSource: UICollectionViewDiffableDataSource<Int, UserInfo>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        collectionView.delegate = self
        collectionView.dataSource = self
        print(list)
    }
    
    override func configure() {
        view.addSubview(collectionView)
    }
    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

}
// MARK: - Compositional Layout
extension NearSesacViewController {
    func configureHierarchy() {
        collectionView.collectionViewLayout = createLayout()
        
        cellRegistration = UICollectionView.CellRegistration<UserCollectionViewCell, UserInfo>(handler: { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            content.text = "\(itemIdentifier.nick)"
//            var content = UIListContentConfiguration.cell()
//            content.background.image = UIImage(named: "sesac_background_\(itemIdentifier.background + 1)")
//            content.sesacImage.image = UIImage(named: "sesac_face_\(itemIdentifier.sesac + 1)")
            
//            content.textProperties.font = Constants.Font.title4!
            
            cell.contentConfiguration = content
        })
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { [weak self] collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: (self?.cellRegistration)!, for: indexPath, item: itemIdentifier)
            return cell
        })
    }
    
    private func createLayout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.showsSeparators = false
        
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    
}
    
// MARK: - UICollectionView - Delegate, DataSource
extension NearSesacViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = list[indexPath.row]
        let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        cell.layer.borderWidth = 0.5
        cell.layer.cornerRadius = 10
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
}

class UserCollectionViewCell: BaseCollectionViewCell {
    let user: UserInfo = UserDefaultsManager.userinfo
    var background: UIImageView = {
        let view = UIImageView()
        return view
    }()
    var sesacImage: UIImageView = {
        let view = UIImageView()
        return view
    }()
    var imageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    var stack: UIStackView = {
        let view = UIStackView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        contentView.addSubview(stack)
        [background, sesacImage].forEach {
            imageView.addSubview($0)
        }
        [imageView].forEach {
            stack.addSubview($0)
        }
    }
    override func setConstraints() {
        stack.snp.makeConstraints { make in
            make.leading.top.equalTo(contentView).offset(16)
            make.trailing.bottom.equalTo(contentView).offset(-16)
        }
        background.snp.makeConstraints { make in
            make.height.equalTo(190)
        }
        sesacImage.snp.makeConstraints { make in
            make.height.width.equalTo(180)
            make.centerY.equalTo(background).offset(16)
            make.centerX.equalTo(background)
        }
        background.image = UIImage(named: "sesac_background_\(user.background + 2)")
        sesacImage.image = UIImage(named: "sesac_face_\(user.sesac + 1)")
    }
}
