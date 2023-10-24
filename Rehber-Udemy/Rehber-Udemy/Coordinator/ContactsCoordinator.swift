//
//  ContactsCoordinator.swift
//  Rehber-Udemy
//
//  Created by batuhan on 7.08.2023.
//

import Foundation
import UIKit

final class ContactsCoordinator:Coordinator{
    
    private(set) var childCoordinators : [Coordinator] = []
    private let navigationControllers : UINavigationController
    
    init(navigationControllers: UINavigationController) {
        self.navigationControllers = navigationControllers
    }
    
    func start() {
        let contactsController = ContactsController()
        let viewModel = ContactsViewModel(view: contactsController)
        viewModel.coordinator = self
        contactsController.viewModel = viewModel
        navigationControllers.setViewControllers([contactsController], animated: true)
    }
    
    func createPage(user:Contact){
        let createCoordinator = CreateCoordinator(navigationController: navigationControllers)
        createCoordinator.parentCoordinator = self
        childCoordinators.append(createCoordinator)
        createCoordinator.start()
    }
    
    func showdetailPage(user:Contact){
        let detailCoordinator = DetailCoordinator(navigationController: navigationControllers, user: user)
        detailCoordinator.parentCoordinator = self
        childCoordinators.append(detailCoordinator)
        detailCoordinator.start()
    }
    
    
    func childDidFinish(childCoordinator:Coordinator){
        if let index = childCoordinators.firstIndex(where: { coordinator in
            return childCoordinator === coordinator
        }){
            childCoordinators.remove(at: index)
            self.navigationControllers.popViewController(animated: true)
        }
    }
}
