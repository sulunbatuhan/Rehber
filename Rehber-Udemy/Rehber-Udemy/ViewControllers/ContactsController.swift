//
//  ContactsController.swift
//  Rehber-Udemy
//
//  Created by batuhan on 6.08.2023.
import UIKit

protocol ContactsControllerProtocol:AnyObject{
    func setTableView()
    func reloadData()
    func navigationBarSettings()
    func refreshControl()
    func didSelect(user: Contact)
}
protocol tableViewHeaderProtocol{
    func reloadData()
    
}

final class ContactsController: UITableViewController, UISearchResultsUpdating, UISearchControllerDelegate,CollectionViewProtocol {
    
    var viewModel : ContactsViewModel?
    
    
    var delegate:tableViewHeaderProtocol?
    
    private let search:UISearchController = {
        let searchBar = UISearchController()
        searchBar.searchBar.barTintColor = .black
        return searchBar
    }()
//    x3rzpDwtdKGm28ezXq
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.viewDidLoad()
        navigationBarSettings()
        setTableView()
        refreshControl()
        search.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel?.viewWillAppear()
    }
    
    
    func refreshControl(){
        let refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
    }
    
    @objc private func refreshTableView(){
        DispatchQueue.main.async {
            self.reloadData()
            self.delegate?.reloadData()
            self.refreshControl?.endRefreshing()
        }
    }
    
    @objc private func addButtonTapped(){
        viewModel?.addButtonTapped()
    }
    
    @objc private func dismissDetail(){
        self.view.endEditing(true)
        navigationController?.popToRootViewController(animated: true)
        
    }
}

extension ContactsController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRowsInSection ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainCell.identifier, for: indexPath) as? MainCell else {return UITableViewCell()}
        cell.contact = viewModel?.cellForRow(indexPath: indexPath.row)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.didSelectRow(at: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action,view,completion)  in
            guard let row = self?.viewModel?.cellForRow(indexPath: indexPath.row) else {return}
            self?.viewModel?.deleteUser(user: row)
            self?.reloadData()
            completion(true)
        }
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: tableViewHeader.identifier) as? tableViewHeader
        header?.delegate = self
        self.delegate = header
        return header
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if viewModel?.favoritesCount == 0 {
            return 0
        }
        return 150
    }
}

//MARK: - Extension func
extension ContactsController : ContactsControllerProtocol{
    func reloadData() {
        tableView.reloadData()
        self.delegate?.reloadData()
    }
    
    func setTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.register(MainCell.self, forCellReuseIdentifier: MainCell.identifier)
        tableView.register(FavoritePersonCell.self, forCellReuseIdentifier: FavoritePersonCell.identifer)
        tableView.register(tableViewHeader.self, forHeaderFooterViewReuseIdentifier: tableViewHeader.identifier)
    }
    
    func navigationBarSettings(){
        navigationItem.searchController = search
        search.searchResultsUpdater = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .black
        navigationItem.title = "Contacts"
        navigationItem.backBarButtonItem?.image = UIImage(systemName: "arrowshape.backward")
        navigationItem.backBarButtonItem?.tintColor = .black
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {return}
        if text == ""{
            viewModel?.fetchData()
            self.reloadData()
        }else {
            viewModel?.searchUser(text: text)
            self.reloadData()
        }
    }
    
    func didSelect(user: Contact) {
        viewModel?.detailPage(user: user)
    }
    
}


