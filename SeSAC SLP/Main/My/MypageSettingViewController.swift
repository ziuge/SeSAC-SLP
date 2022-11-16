//
//  MypageSettingViewController.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/11/15.
//

import UIKit
import MultiSlider

class MypageSettingViewController: BaseViewController {
    
//    var list = [ImageTableViewCell.self, GenderTableViewCell.self]
    
    var tableView: UITableView = {
        let view = UITableView()
        view.register(ImageTableViewCell.self, forCellReuseIdentifier: ImageTableViewCell.reuseIdentifier)
        view.register(GenderTableViewCell.self, forCellReuseIdentifier: GenderTableViewCell.reuseIdentifier)
        view.register(FrequentStudyTableViewCell.self, forCellReuseIdentifier: FrequentStudyTableViewCell.reuseIdentifier)
        view.register(AllowSearchTableViewCell.self, forCellReuseIdentifier: AllowSearchTableViewCell.reuseIdentifier)
        view.register(AgeRangeTableViewCell.self, forCellReuseIdentifier: AgeRangeTableViewCell.reuseIdentifier)
        view.register(SecessionTableViewCell.self, forCellReuseIdentifier: SecessionTableViewCell.reuseIdentifier)
        view.rowHeight = UITableView.automaticDimension
        view.estimatedRowHeight = 130
        view.separatorStyle = .none
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationItem.rightBarButtonItem?.title = "저장"
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func configure() {
        view.addSubview(tableView)
        
    }
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.trailing.leading.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}

extension MypageSettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ImageTableViewCell.reuseIdentifier, for: indexPath) as? ImageTableViewCell else { return UITableViewCell() }
            return cell
        } else if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: GenderTableViewCell.reuseIdentifier, for: indexPath) as? GenderTableViewCell else { return UITableViewCell() }
            return cell
        } else if indexPath.row == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FrequentStudyTableViewCell.reuseIdentifier, for: indexPath) as? FrequentStudyTableViewCell else { return UITableViewCell() }
            return cell
        } else if indexPath.row == 3 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AllowSearchTableViewCell.reuseIdentifier, for: indexPath) as? AllowSearchTableViewCell else { return UITableViewCell() }
            
            return cell
        } else if indexPath.row == 4 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AgeRangeTableViewCell.reuseIdentifier, for: indexPath) as? AgeRangeTableViewCell else { return UITableViewCell() }
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SecessionTableViewCell.reuseIdentifier, for: indexPath) as? SecessionTableViewCell else { return UITableViewCell() }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 200
        } else {
//            return 80
        }
        
        return UITableView.automaticDimension
    }
    
}
