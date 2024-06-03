//
//  SceneDelegate.swift
//  RecipeSearch
//
//  Created by Chris lee on 5/25/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: scene.coordinateSpace.bounds)
        window?.windowScene = scene
        
        let tabBarVC = UITabBarController()
        
        let firstVC = ForYouViewController()
        let secondVC = RecipesViewController()
        
        let nav1 = UINavigationController(rootViewController: firstVC)
        let nav2 = UINavigationController(rootViewController: secondVC)

        //뷰컨 타이틀 설정
        nav1.navigationBar.topItem?.title = "Recipes Search"
        nav1.navigationBar.prefersLargeTitles = true
        nav2.navigationBar.topItem?.title = "My Picks"
        nav2.navigationBar.prefersLargeTitles = true
        
        // 탭바아이템 설정
        nav1.tabBarItem = UITabBarItem(title: "For You", image: UIImage(systemName: "heart.text.square.fill"), tag: 0)
        nav2.tabBarItem = UITabBarItem(title: "Recipes", image: UIImage(systemName: "book.closed.fill"), tag: 1)
        
        // tabBarVC.viewControllers = [nav1, nav2]
        tabBarVC.setViewControllers([nav1, nav2], animated: true)
        
        // UI관련 설정
        tabBarVC.tabBar.layer.borderWidth = 0.50
        tabBarVC.tabBar.layer.borderColor = UIColor.systemGray3.cgColor
        tabBarVC.tabBar.tintColor = .pointColor
        
        window?.rootViewController = tabBarVC
        window?.makeKeyAndVisible()
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

