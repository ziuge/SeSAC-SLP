//
//  ChatViewController.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/12/03.
//

import UIKit

class ChatViewController: BaseViewController {
    
    var chat: [Chat] = []
    var otherNick: String = "000"
    
    // MARK: UI
    var stack: UIStackView = {
        let view = UIStackView()
        return view
    }()
    var matchLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    var bodyLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    var tableView: UITableView = {
        let view = UITableView()
        return view
    }()
    var contentTextView: UITextView = {
        let view = UITextView()
        return view
    }()
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemMint
        
        title = otherNick
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .plain, target: self, action: #selector(showMore))
        
    }
    
    @objc func showMore() {
        print(#function)
        
    }
    
    override func configure() {
        [stack, tableView, contentTextView].forEach {
            view.addSubview($0)
        }
        [matchLabel, bodyLabel].forEach {
            stack.addArrangedSubview($0)
        }
    }
    override func setConstraints() {
        
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
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chat.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let data = chat[indexPath.row]
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: <#T##String#>, for: <#T##IndexPath#>)
        return UITableViewCell()
    }
    
}
