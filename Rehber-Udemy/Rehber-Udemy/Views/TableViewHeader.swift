//
//  TableViewHeader.swift
//  Rehber-Udemy
//
//  Created by batuhan on 4.09.2023.
//

import Foundation
import UIKit

protocol CollectionViewProtocol{
    func didSelect(user:Contact)
}


final class tableViewHeader : UITableViewHeaderFooterView ,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,tableViewHeaderProtocol{
    
 
    
    var delegate: CollectionViewProtocol?
    
    static let identifier = "headerView"
    
    private let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FavoriteCell.self, forCellWithReuseIdentifier: FavoriteCell.identifier)
        fetchData()
    }
    
    var data = [Contact]()
    var favoritesData = [Contact]()
    
    func fetchData(){
        CoreDataManager.shared.fetchData { users in
            self.data = users
        }
        favoritesData = data.filter({ $0.isFavorite == true })
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
}

//MARK: CollectionView
extension tableViewHeader {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoritesData.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCell.identifier, for: indexPath) as? FavoriteCell else {return UICollectionViewCell()}
        cell.contact = favoritesData[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let user = favoritesData[indexPath.row]
        delegate?.didSelect(user:user)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}

//MARK: - tableViewHeaderProtocol
extension tableViewHeader {
    func reloadData() {
        fetchData()
        collectionView.reloadData()
    }
}




//
//protocol CollectionViewModelProtocol{
//    func fetchData()
//    func cellForItem(at:Int)->Contact
//}
//
//class CollectionViewModel :CollectionViewModelProtocol{
//   
//  
//    
//    func cellForItem(at:Int)->Contact{
//        let row = favoritesData[at]
//        return row
//    }
//}
