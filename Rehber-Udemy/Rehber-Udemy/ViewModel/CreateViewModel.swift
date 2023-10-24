//
//  CreateUserViewModel.swift
//  Rehber-Udemy
//
//  Created by batuhan on 7.08.2023.
//

import Foundation
import UIKit

protocol CreateViewModelProtocol{
    func saveUser(name:String,surname:String,number:String,completion:@escaping(Bool)->())
    
    func viewDidLoad()
    
    
    var view : CreateUserProtocol? {get set}
}

final class CreateViewModel:CreateViewModelProtocol{
  
    
    var view: CreateUserProtocol?
    var image:UIImage?
    var coordinator : CreateCoordinator
    
    init(coordinator: CreateCoordinator,view:CreateUserProtocol?=nil){
        self.view = view
        self.coordinator = coordinator
    }
    
    

    func buttonTapped(completion:@escaping(UIImage)->()){
        coordinator.startPickerCoordinator(completion: { [self] image in
            self.image = image
            completion(image)
        })
    }

    func backToContacts(){
        coordinator.didFinishCreate()
    }
}

extension CreateViewModel {
    func saveUser(name:String,surname:String,number:String,completion:@escaping(Bool)->()){
        CoreDataManager.shared.saveData(name: name, surname: surname, phoneNumber: number, isFavorite: false, image: (self.image ?? UIImage(named: "none"))!) { result in
            completion(result)
        }
    }
    
    func viewDidLoad() {
        view?.setTableView()
        view?.setButtons()
        view?.setupNotification()
        view?.addGestureForKeyboard()
    }
}
