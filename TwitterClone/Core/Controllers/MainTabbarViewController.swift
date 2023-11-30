//
//  MainTabbarViewController.swift
//  TwitterClone
//
//  Created by Tammana on 30/11/23.
//

import UIKit

class MainTabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
     //   setupTabs()
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: SearchViewController())
        let vc3 = UINavigationController(rootViewController: NotificationViewController())
        let vc4 = UINavigationController(rootViewController: DirectMessageViewController())

        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc1.tabBarItem.selectedImage = UIImage(systemName: "house.fill")

        vc2.tabBarItem.image = UIImage(systemName: "magnifyingglass")

        vc3.tabBarItem.image = UIImage(systemName: "bell")
        vc3.tabBarItem.selectedImage = UIImage(systemName: "bell.fill")

        vc4.tabBarItem.image = UIImage(systemName: "envelope")
        vc4.tabBarItem.selectedImage = UIImage(systemName: "envelope.fill")

        setViewControllers([vc1, vc2, vc3, vc4], animated: true)
        
        
        
    }
    
    private func setupTabs(){
            let homeVC = HomeViewController()
            let searchVC = SearchViewController()
            let notificationVC = NotificationViewController()
            let dmVC = DirectMessageViewController()
            
            homeVC.navigationItem.largeTitleDisplayMode = .automatic
            searchVC.navigationItem.largeTitleDisplayMode = .automatic
            notificationVC.navigationItem.largeTitleDisplayMode = .automatic
            dmVC.navigationItem.largeTitleDisplayMode = .automatic
            
            
            let homeNav = UINavigationController(rootViewController: homeVC)
            let searchNav = UINavigationController(rootViewController: searchVC)
            let notificationNav = UINavigationController(rootViewController: notificationVC)
            let dmNav = UINavigationController(rootViewController: dmVC)
            
             homeNav.tabBarItem = UITabBarItem(title: "Home"
                                                    , image: UIImage(systemName: "house")
                                                    ,selectedImage: UIImage(systemName: "house.fill")
                                                    )
            
             searchNav.tabBarItem = UITabBarItem(title: "Search"
                                                 , image: UIImage(systemName: "magnifyingglass"),
                                                 selectedImage: nil)
             
            
             notificationNav.tabBarItem = UITabBarItem(title: "Notifications"
                                                    , image: UIImage(systemName: "bell")
                                                    ,selectedImage: UIImage(systemName: "bell.fill")
                                                    )
            
             dmNav.tabBarItem = UITabBarItem(title: "Direct Messages"
                                                    , image: UIImage(systemName: "envelope")
                                                    ,selectedImage: UIImage(systemName: "envelope.fill")
                                                   )
            
            
       
            
            let allNavs = [homeNav, searchNav, notificationNav, dmNav]
            for nav in allNavs {
                nav.navigationBar.prefersLargeTitles = true
            }
            
            setViewControllers(allNavs, animated: true)
            
            
            
        }


}

