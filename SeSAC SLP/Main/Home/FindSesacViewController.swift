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
        
        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap
        
        addBar(bar, dataSource: self, at: .top)
        
    }
}

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
        let title = "Page \(index)"
        return TMBarItem(title: title)
    }
}
