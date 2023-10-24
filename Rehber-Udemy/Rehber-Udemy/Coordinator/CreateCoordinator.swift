//
//  CreateCoordinator.swift
//  Rehber-Udemy
//
//  Created by batuhan on 7.08.2023.
//

import Foundation
import UIKit


final class CreateCoordinator:Coordinator{
    
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController : UINavigationController?
    var parentCoordinator : ContactsCoordinator?
    var completion : (UIImage) -> Void = {_ in}
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let createController = CreateUser()
        let viewModel = CreateViewModel(coordinator: self)
        createController.viewModel = viewModel
        navigationController?.pushViewController(createController, animated: true)
    }
    
    func startPickerCoordinator(completion:@escaping(UIImage)->()){
        guard let navigationController = navigationController else {return}
        let picker = PickerCoordinator(navigationController: navigationController,parentCoordinator: self)
        childCoordinators.append(picker)
        picker.start()
        self.completion = completion
    }
    
    func didFinishPicking(_ image : UIImage){
      completion(image)
        
    }
    
    func didFinishCreate(){
        parentCoordinator?.childDidFinish(childCoordinator: self)
    }

    func childDidFinish(childCoordinator:Coordinator){
        if let index = childCoordinators.firstIndex(where: { coordinator in
            return childCoordinator === coordinator
        }){
            childCoordinators.remove(at: index)
            self.navigationController?.popViewController(animated: true)
        }
    }
}
