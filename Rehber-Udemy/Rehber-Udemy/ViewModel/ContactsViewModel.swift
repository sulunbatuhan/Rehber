//
//  ContactsViewModel.swift
//  Rehber-Udemy
//
//  Created by batuhan on 7.08.2023.
//

import Foundation

protocol ContactsViewModelProtocol{
    var view : ContactsControllerProtocol?{get set}
    func viewDidLoad()
    func cellForRow(indexPath:Int)->Contact
    func didSelectRow(at:Int)
    func addButtonTapped()
    func detailPage(user: Contact)
    func fetchData()
    func deleteUser(user:Contact)
    func searchUser(text:String)
}


final class ContactsViewModel:ContactsViewModelProtocol{
    
    var coordinator : ContactsCoordinator?
    var userData = [Contact]()
    var filterData = [Contact]()
    var favoritesData = [Contact]()
     var view: ContactsControllerProtocol?
    
    init(view: ContactsControllerProtocol) {
        self.view = view
        fetchData()
    }

    var numberOfRowsInSection:Int{
        return filterData.count
    }
    
    var favoritesCount :Int{
        return favoritesData.count
    }
    
    
    func cellForRow(indexPath:Int)->Contact{
        let row = filterData[indexPath]
        return row
    }
    
    func didSelectRow(at indexPath:Int){
        let row = filterData[indexPath]
        detailPage(user: row)
    }
    
}
extension ContactsViewModel {
    
    func addButtonTapped(){
        coordinator?.createPage(user: Contact() )
    }
    func detailPage(user:Contact){
        coordinator?.showdetailPage(user: user)
    }
    
    func fetchData(){
        self.userData.removeAll()
        CoreDataManager.shared.fetchData { [weak self] contact in
            self?.userData = contact
        }
        filterData = userData.sorted(by: {$0.name! < $1.name!})
    }
    
    func fetchFavorites(){
        self.userData.removeAll()
        var data = [Contact]()
        CoreDataManager.shared.fetchData { [weak self] users in
            data = users
        }
        favoritesData = data.filter({ $0.isFavorite == true })
    }
    
    
    func deleteUser(user:Contact){
        CoreDataManager.shared.deleteData(user: user)
        fetchData()
    }
    
    func searchUser(text:String){
        CoreDataManager.shared.searchUser(keyword: text) {[weak self] users in
            self?.userData = users
        }
        self.filterData = self.userData.sorted(by: {$0.name! < $1.name!})
       
    }
    
    func viewDidLoad() {
        view?.navigationBarSettings()
        view?.setTableView()
        view?.refreshControl()
        
    }
    func viewWillAppear(){
        fetchFavorites()
        fetchData()
        view?.reloadData()
    }
}


