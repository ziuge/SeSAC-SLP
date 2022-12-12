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
        cell.parent = self
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 240
//    }
    
}
