//
//  ChatViewController.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/12/03.
//

import UIKit

class ChatViewController: BaseViewController {
    
    var chat: [Chat] = [Chat(id: "", to: "", from: "", chat: "알고리즘 스터디는 언제 하실 예정이세요?", createdAt: ""), Chat(id: "", to: "", from: "", chat: "알고리즘 스터디는 언제 하실 ?", createdAt: ""), Chat(id: "", to: "", from: "", chat: "알고리즘 스터디는 언제?", createdAt: "")]
    var otherNick: String = "000"
    
    // MARK: UI
    var tableView: UITableView = {
        let view = UITableView()
        return view
    }()
    var contentTextView: UITextView = {
        let view = UITextView()
        view.text = "메시지를 입력하세요"
        view.font = Constants.Font.body3
        return view
    }()
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemMint
        
        title = otherNick
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .plain, target: self, action: #selector(showMore))
        
        configureTableView()
    }
    
    @objc func showMore() {
        print(#function)
        
    }
    
    override func configure() {
        [tableView, contentTextView].forEach {
            view.addSubview($0)
        }
    }
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(contentTextView.snp.top)
        }
        contentTextView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(52)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }
    }
}

// MARK: UITableView
extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(YourChatTableViewCell.self, forCellReuseIdentifier: YourChatTableViewCell.reuseIdentifier)
        tableView.register(MyChatTableViewCell.self, forCellReuseIdentifier: MyChatTableViewCell.reuseIdentifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chat.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = chat[indexPath.row]
        
        if indexPath.row.isMultiple(of: 2) {
            let cell = tableView.dequeueReusableCell(withIdentifier: MyChatTableViewCell.reuseIdentifier, for: indexPath) as! MyChatTableViewCell
            cell.chatLabel.text = data.chat
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: YourChatTableViewCell.reuseIdentifier, for: indexPath) as! YourChatTableViewCell
            cell.chatLabel.text = data.chat
            
            return cell
        }
    }
}
