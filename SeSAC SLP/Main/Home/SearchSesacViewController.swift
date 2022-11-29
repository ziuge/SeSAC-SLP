//
//  SearchSesacViewController.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/11/23.
//

import UIKit

class SearchSesacViewController: BaseViewController {
    var tagList: [String] = []
    var studyQueueList: [String] = []
    var studyWantList: [String] = []
    var fromQueueDB: [FromQueueDB] = []
    var fromQueueDBRequested: [FromQueueDB] = []
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(CategoryHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CategoryHeaderView")
        return view
    }()
    let searchBar: UISearchBar = {
        let view = UISearchBar()
        view.placeholder = "띄어쓰기로 복수 입력이 가능해요"
        return view
    }()
    let findSesacButton: SeSACButton = {
        let button = SeSACButton()
        button.setTitle("새싹 찾기", for: .normal)
        return button
    }()
    
    var cellRegistration: UICollectionView.CellRegistration<UICollectionViewCell, String>!
    var dataSource: UICollectionViewDiffableDataSource<Int, String>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboard()
        
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar
        
        configureHierarchy()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name:UIResponder.keyboardWillHideNotification, object: nil)
        findSesacButton.addTarget(self, action: #selector(pushFindSesac), for: .touchUpInside)
    }
    
    @objc func pushFindSesac() {
        let vc = FindSesacViewController()
        vc.fromQueueDB = fromQueueDB
        vc.fromQueueDBRequested = fromQueueDBRequested
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func keyboardWillShow(notification:NSNotification){
        print(#function)
        let userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        findSesacButton.transform = CGAffineTransform(translationX: 0, y: -(keyboardFrame.height - 80))
    }
    
    @objc func keyboardWillHide(notification:NSNotification){
        print(#function)
        let userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        findSesacButton.transform = CGAffineTransform(translationX: 0, y: keyboardFrame.height - 80)
    }
    
    override func configure() {
        [collectionView, findSesacButton].forEach {
            view.addSubview($0)
        }
    }
    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        findSesacButton.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.bottom.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }
    }
    
}
    
// MARK: - Compositional Layout
extension SearchSesacViewController {
    
    func configureHierarchy() {
        collectionView.collectionViewLayout = createLayout()
        
        cellRegistration = UICollectionView.CellRegistration { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.cell()
            content.text = itemIdentifier
            switch indexPath.section {
            case 0:
                content.textProperties.color = Constants.Color.error
                cell.layer.borderColor = Constants.Color.error.cgColor
                //                cell.tintColor = Constants.Color.error
            case 1:
                content.textProperties.color = Constants.Color.black
                cell.layer.borderColor = Constants.Color.gray3.cgColor
            case 2:
                content.textProperties.color = Constants.Color.green
                cell.layer.borderColor = Constants.Color.green.cgColor
                content.image = UIImage(systemName: "xmark")
                //                content.imageProperties.tintColor = Constants.Color.green.cgColor
                //                content.imageProperties.maximumSize = CGSize(width: 10, height: 10)
            default:
                content.textProperties.color = Constants.Color.black
                cell.layer.borderColor = Constants.Color.gray3.cgColor
            }
            
            content.textProperties.font = Constants.Font.title4!
            
            cell.contentConfiguration = content
        }
    }
    
    private func createLayout() -> UICollectionViewLayout {
        
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            
            switch sectionNumber {
                
            case 0: return self.firstLayoutSection()
            case 1: return self.secondLayoutSection()
            case 2: return self.thirdLayoutSection()
            default: return self.firstLayoutSection()
            }
        }
    }
    
    // First Layout
    private func firstLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(30), heightDimension: .estimated(20))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.edgeSpacing = .init(leading: .fixed(0), top: .fixed(8), trailing: .fixed(8), bottom: .fixed(0))
        item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(20))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.edgeSpacing = .init(leading: .fixed(16), top: .fixed(0), trailing: .fixed(16), bottom: .fixed(0))
        let section = NSCollectionLayoutSection(group: group)
        
        let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerFooterSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        sectionHeader.edgeSpacing = .init(leading: .fixed(16), top: .fixed(0), trailing: .fixed(16), bottom: .fixed(0))
        
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
    // Second Layout
    private func secondLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(20), heightDimension: .estimated(20))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.edgeSpacing = .init(leading: .fixed(0), top: .fixed(8), trailing: .fixed(8), bottom: .fixed(0))
        item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(20))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.edgeSpacing = .init(leading: .fixed(16), top: .fixed(0), trailing: .fixed(16), bottom: .fixed(0))
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    // Third Layout
    private func thirdLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(20), heightDimension: .estimated(20))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.edgeSpacing = .init(leading: .fixed(0), top: .fixed(8), trailing: .fixed(8), bottom: .fixed(0))
        item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(20))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.edgeSpacing = .init(leading: .fixed(16), top: .fixed(0), trailing: .fixed(16), bottom: .fixed(0))
        let section = NSCollectionLayoutSection(group: group)
        
        let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerFooterSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        sectionHeader.edgeSpacing = .init(leading: .fixed(16), top: .fixed(0), trailing: .fixed(16), bottom: .fixed(0))
        
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
}
    
// MARK: - UICollectionView - Delegate, DataSource
extension SearchSesacViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var lists = [tagList, studyQueueList, studyWantList]
        let item = lists[indexPath.section][indexPath.item]
        let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        cell.layer.borderWidth = 0.5
        cell.layer.cornerRadius = 10
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let lists = [tagList, studyQueueList, studyWantList]
        if studyWantList.count >= 8 {
            showToast(message: "스터디를 더 이상 추가할 수 없습니다")
        } else {
            switch indexPath.section {
            case 0:
                if studyWantList.contains(lists[indexPath.section][indexPath.row]) {
                    showToast(message: "이미 등록된 스터디입니다")
                } else {
                    studyWantList.append(tagList[indexPath.row])
                }
            case 1:
                if studyWantList.contains(lists[indexPath.section][indexPath.row]) {
                    showToast(message: "이미 등록된 스터디입니다")
                } else {
                    studyWantList.append(studyQueueList[indexPath.row])
                }
            case 2:
                studyWantList.remove(at: indexPath.row)
            default:
                print(indexPath)
            }
            collectionView.reloadData()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let lists = [tagList, studyQueueList, studyWantList]
        return lists[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CategoryHeaderView", for: indexPath) as? CategoryHeaderView else {
            return CategoryHeaderView()
        }
        if indexPath.section == 2 {
            header.label.text = "내가 하고 싶은"
        }
        return header
    }
    
}

// MARK: - SearchBar
extension SearchSesacViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let items = searchBar.text?.split(separator: " ") else { return }
        print("searchButton Clicked \(items)")
        for i in items {
            if studyWantList.count >= 8 {
                showToast(message: "스터디를 더 이상 추가할 수 없습니다")
                break
            }
            if String(i).count > 8 {
                showToast(message: "최소 한 자 이상, 최대 8글자까지 작성 가능합니다")
            } else {
                if studyWantList.contains(String(i)) {
                    showToast(message: "이미 등록된 스터디입니다")
                    continue
                } else {
                    studyWantList.append(String(i))
                }
            }
        }
        searchBar.text = ""
        searchBar.endEditing(true)
        collectionView.reloadData()
    }
}
