//
//  MainTabBarController.swift
//  apollo
//
//  Created by Sear Ahmad on 16/03/23.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    private lazy var homeVC: UINavigationController = {
        let nc = UINavigationController(rootViewController: BlueToothViewController())
        nc.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        nc.tabBarItem.badgeValue = "2"
        nc.tabBarItem.badgeColor = .orange
        return nc
    }()
    
    private lazy var rideListVC: UINavigationController = {
        let nc = UINavigationController()
        nc.tabBarItem = UITabBarItem(title: "Ride List", image: UIImage(systemName: "list.bullet"), tag: 1)
        return nc
    }()
    
    private lazy var mapVC: UINavigationController = {
        let nc = UINavigationController()
        nc.tabBarItem = UITabBarItem(title: "Map", image: UIImage(systemName: "map"), tag: 2)
        return nc
    }()
    
    private lazy var storeVC: UIViewController = {
        let nc = UINavigationController(rootViewController: StoreViewController())
        nc.tabBarItem = UITabBarItem(title: "Store", image: UIImage(systemName: "cart"), tag: 3)
        return nc
    }()
    
    private lazy var settingsVC: UINavigationController = {
        let nc = UINavigationController()
        nc.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gearshape"), tag: 4)
        return nc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        viewControllers = [homeVC, rideListVC, mapVC, storeVC, settingsVC]
        selectedIndex = 3
        tabBar.tintColor = .systemBlue
        tabBar.barTintColor = .clear
        tabBar.isTranslucent = false
    }
}
