//
//  MypageViewController.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/11/15.
//

import UIKit

class MypageViewController: BaseViewController {
    // MARK: UI
    var tableView: UITableView = {
        let view = UITableView()
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemMint
    }
}

