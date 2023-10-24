//
//  ViewController.swift
//  Rehber-Udemy
//
//  Created by batuhan on 2.03.2022.
//

import UIKit
import JGProgressHUD

protocol CreateUserProtocol{
    func setTableView()
    func setButtons()
    func setupNotification()
    func addGestureForKeyboard()
}


final class CreateUser: UIViewController,UserImageDelegate,CreateUserProtocol{
    let header = HeaderView()
    
    var textName : String?
    var textSurname:String?
    var textNumber : String?
    
    var viewModel: CreateViewModel!
    
    
    let progressHud = JGProgressHUD(style: .light)
    
    
    private lazy var tableView : UITableView = {
        let tableView = UITableView()
        tableView.register(TextFieldCell.self, forCellReuseIdentifier: "textFieldCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setTableView()
        setButtons()
        addGestureForKeyboard()
        setupNotification()
        
    }
    
    func setTableView(){
        view.addSubview(tableView)
        tableView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        tableView.isScrollEnabled = false
        tableView.keyboardDismissMode = .interactive
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
    }
    
    func setButtons(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveButton))
        navigationItem.rightBarButtonItem?.tintColor = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(image:UIImage(systemName: "arrow.left"), style: .done, target: self, action: #selector(backToContacts))
    }
    
   func setupNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
}
//MARK: TableView
extension CreateUser:UITableViewDelegate,UITableViewDataSource {
    
    class headerLabel : UILabel {
        override func drawText(in rect: CGRect) {
            super.drawText(in: rect.insetBy(dx: 16, dy: -50))
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 0 : 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let textCell = tableView.dequeueReusableCell(withIdentifier: "textFieldCell", for: indexPath) as? TextFieldCell else {return UITableViewCell()}
        switch indexPath.section {
        case 1:
            textCell.configure(place: "name")
            textCell.textField.addTarget(self, action: #selector(nameEntered), for: .editingChanged)
            return textCell
        case 2:
            textCell.configure(place: "Surname")
            textCell.textField.addTarget(self, action: #selector(surnameEntered), for: .editingChanged)
            return textCell
        case 3:
            textCell.configure(place: "phoneNumber")
            textCell.textField.addTarget(self, action: #selector(numberEntered), for: .editingChanged)
            return textCell
        case 4:
            return textCell
        default:
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = headerLabel()
        if section == 0{
            self.header.delegate = self
            return header
        }
        switch section {
        case 1:
            label.text = "Name"
            label.textColor = .black
            label.font = UIFont.systemFont(ofSize: 14, weight: .light)
            return label
        case 2:
            label.text = "Surname"
            label.textColor = .black
            label.font = UIFont.systemFont(ofSize: 14, weight: .light)
            return label
        case 3:
            label.text = "Phone Number"
            label.textColor = .black
            label.font = UIFont.systemFont(ofSize: 14, weight: .light)
            return label
        default:
            return label
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 200
        }
        return 20
    }
    
}


//MARK: @objc Functions
extension CreateUser{
    @objc private func saveButton(){
        if let name = textName,let surname = textSurname,
           let phoneNumber = textNumber,
           !name.isEmpty || !surname.isEmpty || !phoneNumber.isEmpty {
            
            viewModel?.saveUser(name: name, surname: surname, number: phoneNumber, completion: { result in
                if result == false {
                    let alertController = UIAlertController(title: "HATA!", message: "Kaydedilemedi", preferredStyle: .actionSheet)
                    let action = UIAlertAction(title: "Tamam", style: .destructive)
                    alertController.addAction(action)
                    self.present(alertController, animated: true)
                }
                //                self.progressHud.textLabel.text = "Kaydediliyor"
                //                self.progressHud.show(in: self.view)
                
                self.viewModel?.backToContacts()
            })
        }else {
            let alertController = UIAlertController(title: "HATA!", message: "Eksik veya yanlış girdiniz", preferredStyle: .actionSheet)
            let action = UIAlertAction(title: "Tamam", style: .destructive)
            alertController.addAction(action)
            present(alertController, animated: true)
            return
        }
        
    }
    
    @objc private func backToContacts(){
        viewModel?.backToContacts()
    }
    
    @objc private func nameEntered(textField:UITextField){
        guard let name = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else {return }
        self.textName = name
    }
    
    @objc private func surnameEntered(textField:UITextField){
        guard let surname = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else {return}
        self.textSurname = surname
    }
    
    @objc private func numberEntered(textField:UITextField){
        guard let number = textField.text else {return}
        self.textNumber = number
    }
    
   func buttonTapped() {
       viewModel?.buttonTapped(completion: { image in
            DispatchQueue.main.async {
                self.header.userIcon.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
            }
        })
    }
    
    func addGestureForKeyboard(){
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
    }
    
    @objc private func dismissKeyboard(){
        UIView.animate(withDuration: 0.5){
            self.view.endEditing(true)
            self.view.transform = .identity
        }
    }
    @objc private func keyboardDidShow(){
        UIView.animate(withDuration: 0.5){
            self.view.transform = .identity
        }
    }
    
    @objc private func keyboardShow(notification:Notification){
        guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        let keyboardFrame = value.cgRectValue
        let bottomSpace = tableView.frame.height - 250
        let diff = bottomSpace - keyboardFrame.height
        self.view.transform = CGAffineTransform(translationX: 0, y: -diff)
    }
}
