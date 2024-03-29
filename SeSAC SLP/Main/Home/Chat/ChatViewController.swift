//
//  ChatViewController.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/12/03.
//

import UIKit
import Alamofire

class ChatViewController: BaseViewController {
    
    var chat: [Payload] = []
    var otherNick: String = "000"
    var otheruid: String = "cgP8iswqFEO4VpPxpcWKUbtr0t22"
    
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
        view.isEditable = true
        return view
    }()
    var sendButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "send-unavailable"), for: .disabled)
        view.setImage(UIImage(named: "send-available"), for: .normal)
        view.isEnabled = true
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
        hideKeyboard()
        tabBarController?.tabBar.isHidden = true
        view.backgroundColor = Constants.Color.white
        
        title = otherNick
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .plain, target: self, action: #selector(showMore))
        
        configureTableView()
        
        fetchChats(otheruid: otheruid, lastchatdate: "2022-11-16T06:55:54.784Z")
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name:UIResponder.keyboardWillHideNotification, object: nil)
        sendButton.addTarget(self, action: #selector(sendChat), for: .touchUpInside)
        
        // MARK: 더보기
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showMore))
        moreBlackView.addGestureRecognizer(tapGesture)
        moreBlackView.isUserInteractionEnabled = true
        
        // hidden view button addTarget
        reportButton.addTarget(self, action: #selector(reportButtonClicked), for: .touchUpInside)
        dodgeButton.addTarget(self, action: #selector(dodgeButtonClicked), for: .touchUpInside)
        reviewButton.addTarget(self, action: #selector(reviewButtonClicked), for: .touchUpInside)
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
    
    @objc func sendChat() {
        print(#function)
        postChat(otheruid: otheruid, text: "하이루")
    }
    
    @objc func showMore() {
        print(#function)
        moreView.isHidden.toggle()
        moreBlackView.isHidden.toggle()
    }
    
    @objc func reportButtonClicked() {
        print(#function)
        
    }
    
    @objc func dodgeButtonClicked() {
        print(#function)
        
    }
    
    @objc func reviewButtonClicked() {
        print(#function)
    }
    
    @objc func keyboardWillShow(notification:NSNotification){
        print(#function)
        let userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        contentTextView.transform = CGAffineTransform(translationX: 0, y: -(keyboardFrame.height - 30))
        sendButton.transform = CGAffineTransform(translationX: 0, y: -(keyboardFrame.height - 30))
    }
    
    @objc func keyboardWillHide(notification:NSNotification){
        print(#function)
        let userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        contentTextView.transform = CGAffineTransform(translationX: 0, y: 0)
        sendButton.transform = CGAffineTransform(translationX: 0, y: 0)
    }
    
}

// MARK: Chat Logic
extension ChatViewController {
    
    private func fetchChats(otheruid: String, lastchatdate: String) {
        let api = SeSACAPI.getchat(otheruid: otheruid, lastchatdate: lastchatdate)
        
        AF.request(api.url, method: .get, headers: api.headers).responseDecodable(of: Chat.self) { [weak self] response in
            print("== AF", response)
            switch response.result {
            case .success(let value):
                self?.chat = value.payload
                self?.tableView.reloadData()
//                self?.tableView.scrollToRow(at: IndexPath(row: self!.chat.count - 1, section: 0), at: .bottom, animated: false)
                SocketIOManager.shared.establishConnection()
            case .failure(let error):
                print("fetchChats FAIL", error)
            }
        }
    }
    
    private func postChat(otheruid: String, text: String) {
        print(#function, text)
        let api = SeSACAPI.postchat(otheruid: otheruid, text: text)
        AF.request(api.url, method: .post, headers: api.headers).responseDecodable(of: Payload.self) { response in
            print("response", response)
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
        
//        if indexPath.row.isMultiple(of: 2) {
        if data.from != otheruid {
            let cell = tableView.dequeueReusableCell(withIdentifier: MyChatTableViewCell.reuseIdentifier, for: indexPath) as! MyChatTableViewCell
            cell.chatLabel.text = data.chat
            cell.timeLabel.text = dateToTime(date: stringToDate(string: data.createdAt))
            
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

// MARK: textView Delegate
extension ChatViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
    }
}
