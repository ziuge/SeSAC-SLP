//
//  PageViewController.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/11/07.
//

import UIKit

class PageViewController: UIPageViewController {
    
    var pageViewControllerList: [UIViewController] = []
    
    var vc1: UIViewController = FirstViewController()
    var vc2: UIViewController = SecondViewController()
    var vc3: UIViewController = ThirdViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createPageViewController(vcList: [vc1, vc2, vc3])
        configurePageViewController()
        configurePageControl()
    }
    
    private func createPageViewController(vcList: [UIViewController]) {
        pageViewControllerList = vcList
    }
    
    private func configurePageViewController() {
        delegate = self
        dataSource = self
        
        guard let first = pageViewControllerList.first else { return }
        setViewControllers([first], direction: .forward, animated: false)
    }
    
    private func configurePageControl() {
        let proxy = UIPageControl.appearance()
        proxy.currentPageIndicatorTintColor = Constants.Color.black
        proxy.pageIndicatorTintColor = Constants.Color.gray5
    }
}

// MARK: - PageVC Delegate, DataSource
extension PageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pageViewControllerList.firstIndex(of: viewController) else { return nil }
        let previousIndex = viewControllerIndex - 1
        
        return previousIndex < 0 ? nil : pageViewControllerList[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pageViewControllerList.firstIndex(of: viewController) else { return nil }
        let nextIndex = viewControllerIndex + 1
        
        return nextIndex >= pageViewControllerList.count ? nil : pageViewControllerList[nextIndex]
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let first = viewControllers?.first, let index = pageViewControllerList.firstIndex(of: first) else { return 0 }
        return index
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pageViewControllerList.count
    }

}

