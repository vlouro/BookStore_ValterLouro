//
//  ViewController.swift
//  BookStoreChallenge
//
//  Created by Valter Louro on 07/10/2024.
//

import UIKit

class ViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.isTranslucent = false
        self.tabBar.backgroundColor = .customTabBarColor
        self.tabBar.barTintColor = .customTabBarColor
        self.tabBar.tintColor = .customTabBarTintColor
        self.tabBar.unselectedItemTintColor = .customTabBarUnselectedItem
        self.setupTabControllers()
    }
    
    func setupTabControllers(){
        // Set up the Book View Controller
        let booksViewController = UINavigationController(rootViewController:BooksViewController())
        booksViewController.navigationBar.isHidden = false
        booksViewController.title = "Books"
        //Icon
        let bookIcon = UITabBarItem(title: "Books", image: UIImage(named: "book"), selectedImage: UIImage(named: "book"))
        booksViewController.tabBarItem = bookIcon
        
        let controllers = [booksViewController]
        self.viewControllers = controllers
    }
    
}

extension ViewController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true;
    }
}
