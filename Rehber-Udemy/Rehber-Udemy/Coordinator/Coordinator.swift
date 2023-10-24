//
//  Coordinator.swift
//  Rehber-Udemy
//
//  Created by batuhan on 7.08.2023.
//

import Foundation

protocol Coordinator :AnyObject{
    var childCoordinators:[Coordinator] {get}
    func start()
}
