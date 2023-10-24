//
//  Kisi.swift
//  Rehber-Udemy
//
//  Created by batuhan on 10.03.2022.
//

import Foundation
import UIKit

class User{
    let Ad : String
    let Soyad : String
    let telNo : String
    var image : UIImage?
    
    init(Ad : String, Soyad : String,telNo :  String){
        self.Ad = Ad
        self.Soyad = Soyad
        self.telNo = telNo
    }
    
    var firstLetter : String? {
        return Ad.first?.uppercased()
    }
}
