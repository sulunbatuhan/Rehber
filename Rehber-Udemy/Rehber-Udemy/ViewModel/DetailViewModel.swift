//
//  DetailViewModel.swift
//  Rehber-Udemy
//
//  Created by batuhan on 17.08.2023.
//

import Foundation
import UIKit
protocol DetailViewModelProtocol{
    
}


final class DetailViewModel:DetailViewModelProtocol{
   
    
    var coordinator : DetailCoordinator?
    
    let user : Contact
    
    init(user: Contact) {
        self.user = user
    }
    
    var image : UIImage {
        return UIImage(data: user.userPhoto ?? Data())!
    }
    
    var name : String {
        return user.name ?? ""
    }
    var surname:String{
        return user.surname ?? ""
    }
    var number : String{
        return user.number ?? ""
    }
    
}
