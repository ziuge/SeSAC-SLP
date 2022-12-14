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
        let view = UITableView(frame: CGRect.zero, style: .grouped)
        view.backgroundColor = Constants.Color.white
        return view
    }()
    var contentTextView: UITextView = {
        let view = UITextView()
        view.text = "메시지를 입력하세요"
        view.textColor = Constants.Color.gray7
        view.font = Constants.Font.body3
        view.backgroundColor = Constants.Color.gray1
        view.textContainerInset = UIEdgeInsets(top: 14, left: 12, bottom: 14, right: 44)
        view.layer.cornerRadius = 8
        return view
    }()
    var sendButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "send-unavailable"), for: .disabled)
        view.isEnabled = false
        return view
    }()
    var moreView: UIView = {
        let view = UIView()
        view.isHidden = true
        return view
    }()
    var moreBlackView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Color.black.withAlphaComponent(0.5)
        view.isHidden = true
        return view
    }()
    var moreStack: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .fill
        view.distribution = .fillEqually
        return view
    }()
    var reportButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "siren"), for: .normal)
        view.setTitle("새싹 신고", for: .normal)
        view.setTitleColor(Constants.Color.black, for: .normal)
        view.titleLabel?.font = Constants.Font.title3
        view.alignTextBelow(spacing: 4)
        view.backgroundColor = Constants.Color.white
        return view
    }()
    var dodgeButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "cancel_match"), for: .normal)
        view.setTitle("스터디 취소", for: .normal)
        view.setTitleColor(Constants.Color.black, for: .normal)
        view.titleLabel?.font = Constants.Font.title3
        view.alignTextBelow(spacing: 4)
        view.backgroundColor = Constants.Color.white
        return view
    }()
    var reviewButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "write"), for: .normal)
        view.setTitle("리뷰 등록", for: .normal)
        view.setTitleColor(Constants.Color.black, for: .normal)
        view.titleLabel?.font = Constants.Font.title3
        view.alignTextBelow(spacing: 4)
        view.backgroundColor = Constants.Color.white
        return view
    }()
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        view.backgroundColor = Constants.Color.white
        
        title = otherNick
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .plain, target: self, action: #selector(showMore))
        
        configureTableView()
    }
    
    @objc func showMore() {
        print(#function)
        moreView.isHidden.toggle()
        moreBlackView.isHidden.toggle()
    }
    
    override func configure() {
        [tableView, contentTextView, sendButton, moreView, moreBlackView].forEach {
            view.addSubview($0)
        }
        moreView.addSubview(moreStack)
        [reportButton, dodgeButton, reviewButton].forEach {
            moreStack.addArrangedSubview($0)
        }
    }
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(contentTextView.snp.top)
        }
        contentTextView.snp.makeConstraints { make in
            make.bottom.equalTo(view).offset(-50)
            make.height.equalTo(52)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }
        sendButton.snp.makeConstraints { make in
            make.size.equalTo(20)
            make.centerY.equalTo(contentTextView)
            make.trailing.equalTo(contentTextView).offset(-14)
        }
        moreView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(72)
        }
        moreStack.snp.makeConstraints { make in
            make.horizontalEdges.verticalEdges.equalTo(moreView)
        }
        moreBlackView.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalTo(view)
            make.top.equalTo(moreView.snp.bottom)
        }
        reportButton.snp.makeConstraints { make in
            make.height.equalTo(72)
        }
        dodgeButton.snp.makeConstraints { make in
            make.height.equalTo(72)
        }
        reviewButton.snp.makeConstraints { make in
            make.height.equalTo(72)
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
        tableView.register(ChatTableCustomHeaderView.self, forHeaderFooterViewReuseIdentifier: ChatTableCustomHeaderView.reuseIdentifier)
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
    
    // TableView Header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let chatheaderview = tableView.dequeueReusableHeaderFooterView(withIdentifier: ChatTableCustomHeaderView.reuseIdentifier) as? ChatTableCustomHeaderView else { return UIView() }
        
        return chatheaderview
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 52
    }
}
