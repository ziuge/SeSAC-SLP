//
//  MainViewController.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/11/14.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.Color.white
        UITabBar.appearance().barTintColor = Constants.Color.green
        tabBar.tintColor = .label
        setupVCs()
        
    }
    
    func setupVCs() {
        viewControllers = [
            createNavController(for: HomeViewController(), title: "홈", image: UIImage(named: "home")!),
            createNavController(for: ShopViewController(), title: "새싹샵", image: UIImage(named: "shop")!),
            createNavController(for: FriendViewController(), title: "새싹친구", image: UIImage(named: "friend")!),
            createNavController(for: MypageViewController(), title: "내정보", image: UIImage(named: "my")!)
        ]
    }
    
    fileprivate func createNavController(for rootViewController: UIViewController,
                                         title: String,
                                         image: UIImage) -> UIViewController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
//        nav.navigationBar.prefersLargeTitles = true
//        rootViewController.navigationItem.title = title
        return nav
    }


}
