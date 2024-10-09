//
//  UINavigationController+Extension.swift
//  BookStoreChallenge
//
//  Created by Valter Louro on 07/10/2024.
//

import UIKit

extension UINavigationController {
    
    func appearanceNavigation() {
        self.navigationBar.barTintColor = .customTabBarColor
        self.navigationBar.tintColor = .customBarTintColor
        navigationBar.isTranslucent = false
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .customTabBarColor
        appearance.titleTextAttributes = [.foregroundColor: UIColor.customBarTintColor ?? UIColor.white]
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
        navigationBar.compactAppearance = appearance.copy()
        navigationBar.compactScrollEdgeAppearance = appearance.copy()
    }
}
