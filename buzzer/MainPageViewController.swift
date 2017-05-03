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
            return [self.viewControllerFromStoryboard(withName: "clipperViewController")]
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        setViewControllers(allViewControllers, direction: .forward, animated: true, completion: nil)
    }

    private func viewControllerFromStoryboard(withName name: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: name)
    }
    
    // MARK: UIPageViewControllerDataSource

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return nil
    }

}
