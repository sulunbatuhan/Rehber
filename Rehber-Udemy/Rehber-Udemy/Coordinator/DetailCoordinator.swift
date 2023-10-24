//
//  DetailCoordinator.swift
//  Rehber-Udemy
//
//  Created by batuhan on 17.08.2023.
//

import Foundation
import UIKit

final class DetailCoordinator:Coordinator{
    var childCoordinators: [Coordinator] = []
    var parentCoordinator:ContactsCoordinator?
    var navigationController : UINavigationController
    var user : Contact
    
    init(navigationController: UINavigationController, user:Contact) {
        self.navigationController = navigationController
        self.user = user
    }
    
    func start() {
        let controller = DetailsVC()
        let viewModel = DetailViewModel(user: user)
        viewModel.coordinator = self
        controller.detailViewModel = viewModel
        controller.modalPresentationStyle = .fullScreen
        navigationController.present(controller, animated: true)
    }
    
    
    func didFinish(){
        parentCoordinator?.childDidFinish(childCoordinator: self)
    }
}
