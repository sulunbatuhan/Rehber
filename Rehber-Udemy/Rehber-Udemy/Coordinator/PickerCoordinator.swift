//
//  PickerCoordinator.swift
//  Rehber-Udemy
//
//  Created by batuhan on 7.08.2023.
//

import Foundation
import UIKit
import Photos
import PhotosUI

class PickerCoordinator :NSObject, Coordinator{
    
    
    var childCoordinators: [Coordinator] = []
    var parentCoordinator : CreateCoordinator
    var navigationController : UINavigationController
   
    
    init(navigationController: UINavigationController,parentCoordinator:CreateCoordinator) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
    }
    
    func start() {
        var configuration = PHPickerConfiguration()
        configuration.filter = PHPickerFilter.images
        configuration.selectionLimit = 1
        
        let pickerController = PHPickerViewController(configuration: configuration)
        pickerController.delegate = self
        navigationController.pushViewController(pickerController, animated: true)
    }

    func didFinish(){
        parentCoordinator.childDidFinish(childCoordinator: self)
    }
    
}

extension PickerCoordinator : UINavigationControllerDelegate, PHPickerViewControllerDelegate{
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        results.forEach { result in
            result.itemProvider.loadObject(ofClass: UIImage.self) {[weak self] reading, error in
                guard let image = reading as? UIImage, error == nil else {return}
                self?.parentCoordinator.didFinishPicking(image)
                DispatchQueue.main.async {
                    self?.didFinish()
                }
            }
        }

    }
    
    
}



