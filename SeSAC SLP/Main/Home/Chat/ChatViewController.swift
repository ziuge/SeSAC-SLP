//
//  ChatViewController.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/12/03.
//

import UIKit

class ChatViewController: BaseViewController {
    
    var chat: [Chat] = []
    
    // MARK: UI
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
