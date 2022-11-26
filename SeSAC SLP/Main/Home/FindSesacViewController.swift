//
//  FindSesacViewController.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/11/26.
//

import UIKit
import Tabman
import Pageboy

class FindSesacViewController: TabmanViewController {
    
    private var viewControllers = [NearSesacViewController(), AcceptSesacViewController()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        
        tabBarController?.tabBar.isHidden = true
        
        title = "새싹 찾기"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "찾기 중단", style: .plain, target: self, action: #selector(stopFinding))
        
        // MARK: Tabbar
        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap
        bar.layout.alignment = .centerDistributed
        bar.layout.contentMode = .fit
        bar.layout.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        bar.backgroundColor = .clear
        //버튼 글씨 커스텀
        bar.buttons.customize{ (button) in
            button.tintColor = Constants.Color.black
            button.selectedTintColor = Constants.Color.green
            button.font = Constants.Font.title4!
            button.selectedFont = Constants.Font.title3!
        }
        // indicator 커스텀
        bar.indicator.weight = .custom(value: 2)
        bar.indicator.tintColor = Constants.Color.green
        bar.indicator.overscrollBehavior = .compress
        
        addBar(bar, dataSource: self, at: .top)
        
    }
    
    @objc func stopFinding() {
        dismiss(animated: true)
    }
}

// MARK: TabBar DataSource
extension FindSesacViewController: PageboyViewControllerDataSource, TMBarDataSource {

    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }

    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }

    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }

    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        switch index {
        case 0:
            return TMBarItem(title: "주변 새싹")
        case 1:
            return TMBarItem(title: "받은 요청")
        default:
            return TMBarItem(title: "Page \(index)")
        }
    }
}
