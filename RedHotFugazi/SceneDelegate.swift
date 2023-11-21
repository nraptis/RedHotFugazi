//
//  SceneDelegate.swift
//  RedHotFugazi
//
//  Created by Nicky Taylor on 11/20/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        guard let window = window else { return }
        let orientation = Orientation(interfaceOrientation: windowScene.interfaceOrientation)
        ApplicationController.rootViewModel = RootViewModel(orientation: orientation,
                                                            window: window,
                                                            windowScene: windowScene)
        ApplicationController.rootViewController = RootViewController(rootViewModel: ApplicationController.rootViewModel)
        
        window.rootViewController = ApplicationController.rootViewController
        window.makeKeyAndVisible()
        
        
        DispatchQueue.main.async {
            
            //Why the delay? This is for safe area layout guide, which trips off
            //if we try to immediately latch.
            
            let homeGridViewModel = HomeGridViewModel()
            let homeGridContainerViewController = HomeGridContainerViewController(homeGridViewModel: homeGridViewModel)
            ApplicationController.rootViewController.push(viewController: homeGridContainerViewController,
                                                          fromOrientation: orientation,
                                                          toOrientation: orientation,
                                                          fixedOrientation: false,
                                                          animated: false,
                                                          reversed: false)
            
        }
    }
}

