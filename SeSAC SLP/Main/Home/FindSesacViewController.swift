//
//  FindSesacViewController.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/11/26.
//

import UIKit
import Alamofire
import Tabman
import Pageboy

class FindSesacViewController: TabmanViewController {
    
    var fromQueueDB: [FromQueueDB] = []
    var fromQueueDBRequested: [FromQueueDB] = []
    
    private var viewControllers = [FindNearSesacViewController(), AcceptSesacViewController()]
    
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

    // 새싹 찾기 중단
    @objc func stopFinding() {
        print(#function)
        self.dismiss(animated: true)
        let api = SeSACAPI.stop
        AF.request(api.url, method: .delete, headers: api.headers).responseString { [weak self] response in
            switch response.result {
            case .success(_):
                guard let statuscode = response.response?.statusCode else { return }
                
                print("success", statuscode)
//                let vc = self?.navigationController?.viewControllers.first(where: { $0 is MainViewController })
                self?.navigationController?.popToRootViewController(animated: true)
//                self?.navigationController?.popViewController(animated: true)
                
            case .failure(_):
                guard let statuscode = response.response?.statusCode else { return }
                
                print("fail", statuscode)
                self?.dismiss(animated: true)
                self?.showToast(message: "찾기 중단 실패")
            }
        }
    }
}

// MARK: TabBar DataSource
extension FindSesacViewController: PageboyViewControllerDataSource, TMBarDataSource {

    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }

    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        if index == 0 {
            if let vc = viewControllers[0] as? FindNearSesacViewController {
                vc.fromQueueDB = fromQueueDB
            }
        } else {
            if let vc = viewControllers[1] as? AcceptSesacViewController {
                vc.fromQueueDBRequested = fromQueueDBRequested
            }
        }
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
