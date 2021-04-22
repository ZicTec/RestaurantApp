//
//  SceneDelegate.swift
//  BottleRocketTest
//
//  Created by Eze Emenike on 4/13/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let tabBar = UITabBarController()
        tabBar.viewControllers = [createLunchNC(), createInternetNC()]
        self.tabBarVisualSetUp()
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = tabBar
        window?.makeKeyAndVisible()
    }
    
    private func tabBarVisualSetUp() {
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Avenir Next Regular", size: 10) as Any, NSAttributedString.Key.foregroundColor: UIColor(displayP3Red: 151/255, green: 151/255, blue: 151/255, alpha: 1.0)], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Avenir Next Regular", size: 10) as Any, NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        UITabBar.appearance().barTintColor = UIColor(displayP3Red: 42/255, green: 42/255, blue: 42/255, alpha: 1.0)
        UITabBar.appearance().tintColor = UIColor.white
    }
    
    private func createLunchNC() -> UINavigationController {
        let lunchVC = LunchVC()
        lunchVC.title = "Lunch Tyme"
        let lunchImage = UIImage(named: "tab_lunch")
        lunchVC.tabBarItem = UITabBarItem(title: "lunch", image: lunchImage, tag: 0)
        let navC = UINavigationController(rootViewController: lunchVC)
        navC.navigationBar.barTintColor = UIColor(displayP3Red: 126/255, green: 214/255, blue: 142/255, alpha: 1.0)
        navC.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Avenir Next Demi Bold", size: 17) as Any, NSAttributedString.Key.foregroundColor: UIColor.white]
        return navC
    }
    
    private func createInternetNC() -> UINavigationController {
        let internetVC = InternetVC()
        let internetImage = UIImage(named: "tab_internets")
        internetVC.tabBarItem = UITabBarItem(title: "internet", image: internetImage, tag: 1)
        let navC = UINavigationController(rootViewController: internetVC)
        navC.navigationBar.barTintColor = UIColor(displayP3Red: 126/255, green: 214/255, blue: 142/255, alpha: 1.0)
        return navC
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

