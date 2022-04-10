//
//  ViewController.swift
//  NetflexClone
//
//  Created by 김희진 on 2022/04/03.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        
        let vc = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: UpCommingViewController())
        let vc3 = UINavigationController(rootViewController: SearchViewController())
        let vc4 = UINavigationController(rootViewController: DownloadsViewController())
        

        vc.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "play.circle")
        vc3.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        vc4.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
        
        vc.title = "home"
        vc2.title = "Coming soon"
        vc3.title = "Search"
        vc4.title = "Download"

        tabBar.tintColor = .label
        
        setViewControllers([vc,vc2,vc3, vc4], animated: true)
    }
}

