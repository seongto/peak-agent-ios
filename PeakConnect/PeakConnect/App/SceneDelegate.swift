//
//  SceneDelegate.swift
//  PeakConnect
//
//  Created by MaxBook on 5/12/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)

        let mainVC = UINavigationController(rootViewController: MainViewController())
        mainVC.navigationBar.tintColor = .white
        let historyVC = UINavigationController(rootViewController: HistoryViewController())
        historyVC.navigationBar.tintColor = .white
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers([mainVC, historyVC], animated: false)
        
        tabBarController.tabBar.tintColor = .primary

        if let items = tabBarController.tabBar.items, items.count >= 2 {
            items[0].image = UIImage(systemName: "house.fill")
            items[0].title = "홈"
            items[0].setTitleTextAttributes([
                .font: UIFont(name: "Pretendard-Medium", size: 9),
            ], for: .normal)
            items[1].image = UIImage(systemName: "clock.fill")
            items[1].title = "히스토리"
            items[1].setTitleTextAttributes([
                .font: UIFont(name: "Pretendard-Medium", size: 9),
            ], for: .normal)
        }

        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        self.window = window
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }

    func sceneWillResignActive(_ scene: UIScene) {
        
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}
