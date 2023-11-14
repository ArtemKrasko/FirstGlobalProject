//
//  ViewController.swift
//  MyFirestWorkMovieApp
//
//  Created by Artem Krasko on 03.11.2022.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        let viewOne = UINavigationController(rootViewController: HomeViewController())
        let viewTwo = UINavigationController(rootViewController: UpcomingViewController())
        let viewThree = UINavigationController(rootViewController: SearchViewController())
        let viewFour = UINavigationController(rootViewController: DownloadViewController())
        
        viewOne.tabBarItem.image = UIImage(systemName: "house")
        viewTwo.tabBarItem.image = UIImage(systemName: "play.circle")
        viewThree.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        viewFour.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
        
        
        viewOne.title = "Home"
        viewTwo.title = "Coming Soon"
        viewThree.title = "Top Search"
        viewFour.title = "Downloads"
        
        
        tabBar.tintColor = .label
        
        setViewControllers([viewOne, viewTwo, viewThree, viewFour], animated: true)
    }


}

