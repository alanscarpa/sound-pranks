//
//  MainPageViewController.swift
//  buzzer
//
//  Created by Alan Scarpa on 5/3/17.
//  Copyright © 2017 The Scarpa Group. All rights reserved.
//

import UIKit

class MainPageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    lazy var allViewControllers: [UIViewController] = {
            return [self.viewControllerFromStoryboard(withName: "clipperViewController"), self.viewControllerFromStoryboard(withName: "bugViewController"), self.viewControllerFromStoryboard(withName: "scaryViewController"), self.viewControllerFromStoryboard(withName: "toiletViewController")]
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        setViewControllers([allViewControllers.first!], direction: .forward, animated: true, completion: nil)
    }

    private func viewControllerFromStoryboard(withName name: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: name)
    }
    
    // MARK: UIPageViewControllerDataSource

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = allViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard allViewControllers.count > previousIndex else {
            return nil
        }
        
        return allViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = allViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = allViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return allViewControllers[nextIndex]
    }

}
