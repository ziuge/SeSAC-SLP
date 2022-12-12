//
//  AcceptSesacViewController.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/11/26.
//

import UIKit

class AcceptSesacViewController: BaseViewController {
    
    var fromQueueDBRequested: [FromQueueDB] = []
    
    let tableView: UITableView = {
        let view = UITableView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AcceptSesacTableViewCell.classForCoder(), forCellReuseIdentifier: AcceptSesacTableViewCell.reuseIdentifier)
        print(fromQueueDBRequested)
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

extension AcceptSesacViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if fromQueueDBRequested.count == 0 {
            tableView.setEmptyMessage("아직 받은 요청이 없어요ㅠ", submessage: "스터디를 변경하거나 조금만 더 기다려 주세요!")
        } else {
            tableView.restore()
        }
        
        return fromQueueDBRequested.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AcceptSesacTableViewCell.reuseIdentifier, for: indexPath) as? AcceptSesacTableViewCell else { return UITableViewCell() }
        cell.user = fromQueueDBRequested[indexPath.row]
        cell.nickButton.setTitle("\(fromQueueDBRequested[indexPath.row].nick)", for: .normal)
        cell.background.image = UIImage(named: "sesac_background_\(fromQueueDBRequested[indexPath.row].background + 1)")
        cell.sesacImage.image = UIImage(named: "sesac_face_\(fromQueueDBRequested[indexPath.row].sesac + 1)")
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 240
//    }
    
}

