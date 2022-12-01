//
//  FindNearSesacViewController.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/11/26.
//

import UIKit

class FindNearSesacViewController: BaseViewController {
    
    var fromQueueDB: [FromQueueDB] = []
    
    let tableView: UITableView = {
        let view = UITableView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FindUserTableViewCell.classForCoder(), forCellReuseIdentifier: FindUserTableViewCell.reuseIdentifier)
        print(fromQueueDB)
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
        return fromQueueDB.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FindUserTableViewCell.reuseIdentifier, for: indexPath) as? FindUserTableViewCell else { return UITableViewCell() }
        cell.user = fromQueueDB[indexPath.row]
        cell.nickButton.setTitle("\(fromQueueDB[indexPath.row].nick)", for: .normal)
        cell.background.image = UIImage(named: "sesac_background_\(fromQueueDB[indexPath.row].background + 1)")
        cell.sesacImage.image = UIImage(named: "sesac_face_\(fromQueueDB[indexPath.row].sesac + 1)")
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 240
//    }
    
}

class FindUserTableViewCell: BaseTableViewCell {
    var user: FromQueueDB = FromQueueDB(uid: "", nick: "", lat: 0, long: 0, reputation: [], studylist: [], reviews: [], gender: 0, type: 0, sesac: 0, background: 0)
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
        view.layer.cornerRadius = 10
        return view
    }()
    var requestButton: SeSACButton = {
        let view = SeSACButton()
        view.setColor(backgroundColor: Constants.Color.error, borderColor: .clear, textColor: Constants.Color.white, for: .normal)
        view.setTitle("요청하기", for: .normal)
        view.titleLabel?.font = Constants.Font.title3
        return view
    }()
    lazy var stack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        return view
    }()
    var nickButton: SeSACButton = {
        let view = SeSACButton()
        view.setColor(backgroundColor: Constants.Color.white, borderColor: Constants.Color.gray3, textColor: Constants.Color.black, for: .normal)
        view.layer.borderWidth = 0.5
        view.titleLabel?.textAlignment = .left
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        requestButton.addTarget(self, action: #selector(requestButtonClicked), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func requestButtonClicked() {
        print(#function)
        let vc = RequestSesacPopUpViewController()
        
    }
    
    override func configure() {
        contentView.addSubview(stack)
        [background, sesacImage].forEach {
            images.addSubview($0)
        }
        [images, nickButton].forEach {
            stack.addArrangedSubview($0)
        }
        contentView.addSubview(requestButton)
    }
    override func setConstraints() {
        stack.snp.makeConstraints { make in
            make.leading.top.equalTo(contentView).offset(16)
            make.trailing.bottom.equalTo(contentView).offset(-16)
        }
        images.snp.makeConstraints { make in
//            make.leading.top.trailing.bottom.equalTo(stack)
            make.height.greaterThanOrEqualTo(190)
        }
        nickButton.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
        background.snp.makeConstraints { make in
            make.height.equalTo(190)
        }
        sesacImage.snp.makeConstraints { make in
            make.height.width.equalTo(170)
            make.centerY.equalTo(background).offset(16)
            make.centerX.equalTo(background)
        }
        requestButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(80)
            make.trailing.equalTo(stack).offset(-12)
            make.top.equalTo(stack).offset(12)
        }
        nickButton.setTitle("  \(user.nick)", for: .normal)
        background.image = UIImage(named: "sesac_background_\(user.background + 2)")
        sesacImage.image = UIImage(named: "sesac_face_\(user.sesac + 1)")
    }
}
