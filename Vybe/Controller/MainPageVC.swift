//
//  MainPageVC.swift
//  Vybe
//
//  Created by Trevor Rose on 2/25/18.
//  Copyright © 2018 Trevor Rose. All rights reserved.
//

import UIKit

class MainPageVC: UIPageViewController {

    lazy var pages: [UIViewController] = {
       return [
            self.grabViewController(name: "LeftVC"),
            self.grabViewController(name: "CaptureVC"),
            self.grabViewController(name: "RightVC")
        ]
    }()
    
    private func grabViewController(name: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "\(name)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        
        let secondViewController = pages[1]
        self.setViewControllers([secondViewController], direction: .forward, animated: true, completion: nil)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension MainPageVC: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.index(of: viewController) else {
            return nil
        }
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        guard pages.count > previousIndex else {
            return nil
        }
        return pages[previousIndex]
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = pages.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return pages[nextIndex]
    }
}
