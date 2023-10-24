//
//  Observable.swift
//  Rehber-Udemy
//
//  Created by batuhan on 11.08.2023.
//

import Foundation

class Observable<T>{
    
    var value : T? {
        didSet{
            observer?(value)
        }
    }
    
    var observer : ((T?)->())?
    
    func bind(observer : @escaping(T?)->()){
        self.observer = observer
    }
}


	
