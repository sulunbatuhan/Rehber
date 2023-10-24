//
//  DetailsVC.swift
//  Rehber
//
//  Created by batuhan on 11.10.2023.
//

import UIKit

final class DetailsVC: UIViewController,UIScrollViewDelegate  {
    
    var detailViewModel : DetailViewModel!{
        didSet{
            user = detailViewModel.user
            infoLabel.text = "\(detailViewModel.name) \(detailViewModel.surname)"
            number.text = detailViewModel.number
            imageView.image = detailViewModel.image
            if user.isFavorite == true {
                let config = UIImage.SymbolConfiguration(pointSize: 40, weight: .medium)
                favoriteButton.setImage(UIImage(systemName: "heart.fill",withConfiguration: config), for: .normal)
            }
        }
    }
    
    var user : Contact!
    
    lazy var scrollView : UIScrollView = {
        let sv = UIScrollView()
        sv.alwaysBounceVertical = true
        sv.contentInsetAdjustmentBehavior = .never
        sv.delegate = self
        return sv
    }()
    
    private let imageView : UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "none")?.withRenderingMode(.alwaysOriginal)
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        return imgView
    }()
    
    private let infoLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    
    private let callButton : UIButton = {
        let button = UIButton(type: .system)
        let largeConfig = UIImage.SymbolConfiguration(pointSize:40, weight: .medium)
        let largeBoldDoc = UIImage(systemName: "phone.circle.fill",withConfiguration: largeConfig)
        button.setImage(largeBoldDoc,for : .normal)
        button.addTarget(self, action: #selector(callUser), for: .touchUpInside)
        button.tintColor = .systemGreen
        return button
    }()
    
    private let messageButton:UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .systemGreen
        let config = UIImage.SymbolConfiguration(pointSize: 40, weight: .medium)
        button.setImage(UIImage(systemName: "message.circle.fill",withConfiguration: config), for: .normal)
        button.addTarget(self, action: #selector(sendToSMS), for: .touchUpInside)
        return button
    }()
    private  let videoButton:UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .systemGreen
        let config = UIImage.SymbolConfiguration(pointSize: 40, weight: .medium)
        button.setImage(UIImage(systemName: "video.circle.fill",withConfiguration: config), for: .normal)
        button.addTarget(self, action: #selector(makeFacetimeCall), for: .touchUpInside)
        return button
    }()
    private let cancelButton:UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .systemRed
        let config = UIImage.SymbolConfiguration(pointSize: 40, weight: .medium)
        button.setImage(UIImage(systemName: "xmark",withConfiguration: config), for: .normal)
        button.addTarget(self, action: #selector(handleTapDismiss), for: .touchUpInside)
        return button
    }()
    
    private let number:UILabel = {
        let number = UILabel()
        let attr : [NSAttributedString.Key:Any] = [.font : UIFont.systemFont(ofSize: 20,weight: .light)]
        //        number.attributedText = NSMutableAttributedString(string: number.text!, attributes: attr)
        return number
    }()
    
   private let favoriteButton:UIButton = {
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 40, weight: .medium)
        button.setImage(UIImage(systemName: "heart",withConfiguration: config), for: .normal)
        button.addTarget(self, action: #selector(addFavorited), for: .touchUpInside)
        button.tintColor = .systemYellow
        return button
    }()
    @objc private func addFavorited(button:UIButton){
        let config = UIImage.SymbolConfiguration(pointSize: 40, weight: .medium)
        if detailViewModel?.user.isFavorite == false {
            button.setImage(UIImage(systemName: "heart.fill",withConfiguration: config), for: .normal)
            CoreDataManager.shared.updateData(user: user)
        }else {
            button.setImage(UIImage(systemName: "heart",withConfiguration: config), for: .normal)
            CoreDataManager.shared.updateData(user: user)
        }
    }
    
    private func visualEffect(){
        let blurEffect = UIBlurEffect(style: .regular)
        let visualEffect = UIVisualEffectView(effect: blurEffect)
        view.addSubview(visualEffect)
        visualEffect.anchor(top: view.topAnchor, bottom: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubviews(imageView,infoLabel,favoriteButton,number)
        visualEffect()
        setStackView()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss)))
    }
    private func setStackView(){
        let buttonStackView = UIStackView(arrangedSubviews: [messageButton,callButton,videoButton])
        buttonStackView.axis = .horizontal
        buttonStackView.spacing = 4
        buttonStackView.distribution = .fillEqually
        scrollView.addSubview(buttonStackView)
        buttonStackView.anchor(top: nil, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: -20, paddingLeft: 40, paddingRight: -40, width: 0, height: 100)
    }
    
    
    @objc private func handleTapDismiss(){
        self.dismiss(animated: true)
    }
    
    
    override func viewDidLayoutSubviews() {
        setLayout()
    }
    
    private  func setLayout(){
        scrollView.anchor(top: view.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.width)
        infoLabel.anchor(top: imageView.bottomAnchor, bottom: nil, leading: scrollView.leadingAnchor, trailing: scrollView.trailingAnchor, paddingTop: 16, paddingBottom: 0, paddingLeft: 16, paddingRight: -16, width: 0, height: 0)
        number.anchor(top: infoLabel.bottomAnchor, bottom: nil, leading: scrollView.leadingAnchor, trailing: scrollView.trailingAnchor, paddingTop: 16, paddingBottom: 0, paddingLeft: 16, paddingRight: -16, width: 0, height: 0)
        favoriteButton.anchor(top: nil, bottom: imageView.bottomAnchor, leading: nil, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 50, paddingLeft: 0, paddingRight: -16, width: 100, height: 100)
    }
    
    let topHeigth = UIApplication.shared.statusBarFrame.height  + 8
    
     func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let changeY = -scrollView.contentOffset.y
        var width =  view.frame.width + changeY * 2
        width = max(view.frame.width, width)
        var minSettings = min(0, -changeY)
        imageView.frame = CGRect(x: minSettings, y:minSettings, width: width, height: width + topHeigth)
    }
    
    
    @objc private func sendToSMS() {
        UIApplication.shared.open(URL(string: "sms:05399274754")!, options: [:], completionHandler: nil)
    }
    @objc private func callUser(){
        if let url = URL(string: "facetime://5399274754"){
            UIApplication.shared.open(url)
        }
    }
    
    @objc private func makeFacetimeCall(){
        if let facetimeURL = URL(string: "facetime://5399274754"){
            if (UIApplication.shared.canOpenURL(facetimeURL)){
                UIApplication.shared.open(facetimeURL)
            }
        }
    }
}
