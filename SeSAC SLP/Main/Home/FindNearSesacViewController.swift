//
//  FindNearSesacViewController.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/11/26.
//

import UIKit

class FindNearSesacViewController: BaseViewController {
    
    var list = [UserDefaultsManager.userinfo]
    
    let tableView: UITableView = {
        let view = UITableView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        print(list)
    }
    
    override func configure() {
        view.addSubview(tableView)
    }
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}

extension FindNearSesacViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FindUserTableViewCell.reuseIdentifier, for: indexPath) as? FindUserTableViewCell else { return UITableViewCell() }
        cell.background.image = UIImage(named: "sesac_background_\(list[indexPath.row].background + 1)")
        cell.sesacImage.image = UIImage(named: "sesac_face_\(list[indexPath.row].sesac + 1)")
        return cell
    }
    
}

class FindUserTableViewCell: BaseTableViewCell {
    let user: UserInfo = UserDefaultsManager.userinfo
    var background: UIImageView = {
        let view = UIImageView()
        return view
    }()
    var sesacImage: UIImageView = {
        let view = UIImageView()
        return view
    }()
    var images: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .systemCyan
        return view
    }()
    var stack: UIStackView = {
        let view = UIStackView()
        return view
    }()
    var nickLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        contentView.addSubview(stack)
        [background, sesacImage].forEach {
            images.addSubview($0)
        }
        [images, nickLabel].forEach {
            stack.addSubview($0)
        }
    }
    override func setConstraints() {
        stack.snp.makeConstraints { make in
            make.leading.top.equalTo(contentView).offset(16)
            make.trailing.bottom.equalTo(contentView).offset(-16)
        }
        images.snp.makeConstraints { make in
            
        }
        nickLabel.snp.makeConstraints { make in
            
        }
        background.snp.makeConstraints { make in
            make.height.equalTo(190)
        }
        sesacImage.snp.makeConstraints { make in
            make.height.width.equalTo(180)
            make.centerY.equalTo(background).offset(16)
            make.centerX.equalTo(background)
        }
        nickLabel.text = "\(user.nick)"
        background.image = UIImage(named: "sesac_background_\(user.background + 2)")
        sesacImage.image = UIImage(named: "sesac_face_\(user.sesac + 1)")
    }
}
