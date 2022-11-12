//
//  BaseViewController.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/11/07.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.Color.white
        navigationItem.backButtonTitle = ""
        configure()
        setConstraints()
    }
    
    func configure() { }
    func setConstraints() { }
    
}
