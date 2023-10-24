//
//  MainCoordinator.swift
//  Rehber-Udemy
//
//  Created by batuhan on 7.08.2023.
//

import Foundation
import UIKit

final class AppCoordinator:Coordinator{
    private(set) var childCoordinators = [Coordinator]()
    private  let window : UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let navigationControllers = UINavigationController()
        let contactsCoordinator = ContactsCoordinator(navigationControllers: navigationControllers)
        contactsCoordinator.start()
        self.childCoordinators.append(contactsCoordinator)
        window.rootViewController = navigationControllers
        window.makeKeyAndVisible()
    }
}
