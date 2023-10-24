//
//  DataManagement.swift
//  Rehber-Udemy
//
//  Created by batuhan on 7.08.2023.
//

import Foundation
import UIKit
import CoreData

protocol CoreDataProtocol{
    func fetchData(completion:@escaping([Contact])->())
    func saveData(name:String,surname:String,phoneNumber:String,isFavorite:Bool,image:UIImage,completion:@escaping(Bool)->())
    func updateData(user:Contact)
    func deleteData(user:Contact)
    func searchUser(keyword:String,completion:@escaping ([Contact])->())
}

final class CoreDataManager:CoreDataProtocol{
    static let shared = CoreDataManager()

    lazy var persistentContainer : NSPersistentContainer = {
       let container = NSPersistentContainer(name: "Contacts")
        container.loadPersistentStores { storeDescription, error in
            if let error  = error {
                print("Error\(error)")
            }
        }
        return container
    }()
    
    func saveContext(){
        let context = persistentContainer.viewContext
        if context.hasChanges{
            do {
                try context.save()
            }catch{
                print(error)
            }
        }
    }

    
    func fetchData(completion:@escaping([Contact])->()){
        do {
            let liste = try persistentContainer.viewContext.fetch(Contact.fetchRequest())
            completion(liste)
        }catch{
        //hata yakalama
        }
    }
    
    func saveData(name:String,surname:String,phoneNumber:String,isFavorite:Bool,image:UIImage,completion:@escaping(Bool)->()){
        let user = Contact(context: persistentContainer.viewContext)
        user.name = name
        user.surname = surname
        user.number = phoneNumber
        if isFavorite == true {
            user.isFavorite = true
        }else {
            user.isFavorite = false
        }
        user.userPhoto = image.jpegData(compressionQuality: 0.5)
        saveContext()
        completion(true)
        
    }
    
    func updateData(user:Contact){
        let result = user.value(forKey: "isFavorite")
        if result as! Int == 0{
            user.setValue(true, forKey: "isFavorite")
        }else{
            user.setValue(false, forKey: "isFavorite")
        }
    }
    
    func deleteData(user:Contact){
        self.persistentContainer.viewContext.delete(user)
        saveContext()
    }
    
    func searchUser(keyword:String,completion:@escaping ([Contact])->()){
        let fetchRequest = Contact.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name CONTAINS %@", keyword)
        do{
            let list = try persistentContainer.viewContext.fetch(fetchRequest)
            completion(list)
        }catch{
            
        }
    }
}
