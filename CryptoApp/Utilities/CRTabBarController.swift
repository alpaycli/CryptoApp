//
//  CRTabBarController.swift
//  CryptoApp
//
//  Created by Alpay Calalli on 30.09.23.
//

import UIKit

class CRTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemGreen
        viewControllers = [createHomeVC()]
    }
    
    
    func createHomeVC() -> UINavigationController {
        let homeVC = HomeVC()
        homeVC.title = "Home"
        homeVC.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 0)
        
        return UINavigationController(rootViewController: homeVC)
    }
}
