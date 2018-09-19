//
//  MenuLauncher.swift
//  DeanzaClassRegister
//
//  Created by Alvin Lin on 2018/9/12.
//  Copyright © 2018 Alvin Lin. All rights reserved.
//

import UIKit

class MenuLauncher: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private let cellId = "cellId"
    let labelString = ["Home", "Subscribe", "Favorite", "Notification", "Settings", "Help", "Log out"]
    let imageString = ["home", "subscribe", "star", "mail", "settings", "information", "logout"]
    var baseController: TableViewController?
    
    let menuView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let profileView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let imageButton: UIButton = {
        let bt = UIButton()
        return bt
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let blackView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    open func showMenu() {
        
        if let window = UIApplication.shared.keyWindow {
            // blackView
            window.addSubview(blackView)
            blackView.alpha = 0.5
            blackView.frame = CGRect(x: 0, y: 0, width: window.frame.width, height: window.frame.height)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            // menuView
            window.addSubview(menuView)
            menuView.frame = CGRect(x: -250, y: 0, width: 250, height: window.frame.height)
            UIView.animate(withDuration: 0.5) {
                self.menuView.frame = CGRect(x: 0, y: 0, width: 250, height: window.frame.height)
            }
            
            // profileView
            menuView.addSubview(profileView)
            profileView.frame = CGRect(x: 50, y: 50, width: 150, height: 150)
            profileView.layer.cornerRadius = 75
            profileView.image = UIImage(named: "user")?.withRenderingMode(.alwaysTemplate)
            profileView.contentMode = .scaleToFill
            profileView.clipsToBounds = true
            profileView.translatesAutoresizingMaskIntoConstraints = false
            profileView.tintColor = .black
            
            // imageButton
            menuView.addSubview(imageButton)
            imageButton.frame = CGRect(x: profileView.frame.origin.x + profileView.frame.width - 50, y: profileView.frame.origin.y + profileView.frame.height - 50, width: 50, height: 50)
            imageButton.setImage(UIImage(named: "camera"), for: UIControlState())
            imageButton.backgroundColor = .white
            imageButton.layer.cornerRadius = 25
            imageButton.layer.borderWidth = 1
            imageButton.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            imageButton.addTarget(self, action: #selector(handleImageButton), for: .touchUpInside)
            
            
            // collectionView
            menuView.addSubview(collectionView)
            let collectionHeight:CGFloat = CGFloat(labelString.count * 40)
            collectionView.frame = CGRect(x: 0, y: 250, width: menuView.frame.width, height: collectionHeight)
        }
    }
    
    @objc func handleImageButton() {
        print("button")
    }
    
    @objc func handleDismiss() {
        if let window = UIApplication.shared.keyWindow {
            self.blackView.alpha = 0
            UIView.animate(withDuration: 0.5) {
                self.menuView.frame = CGRect(x: -250, y: 0, width: 250, height: window.frame.height)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return labelString.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCollectionViewCell
        
        cell.label.text = labelString[indexPath.row]
        
        let image = UIImage(named: imageString[indexPath.row])?.withRenderingMode(.alwaysTemplate)
        cell.imageView.image = image
        cell.imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let space: CGFloat = 0
        return space
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let title = labelString[indexPath.row]
        print(title, indexPath)
        
        
        switch labelString[indexPath.row] {
        case "Home":
            let destination = TableViewController()
            destination.selectedIndexPath = indexPath
            isFirstTime = false
            handlePushAnimate(title: title, destination: destination)
        case "Subscribe":
            let destination = SubscribeViewController()
            destination.baseController = baseController
            destination.selectedIndexPath = indexPath
            handlePushAnimate(title: title, destination: destination)
        case "Favorite":
            let destination = FavoriteViewController()
            destination.baseController = baseController
            destination.selectedIndexPath = indexPath
            handlePushAnimate(title: title, destination: destination)
        case "Notification":
            let destination = NotificationViewController()
            destination.baseController = baseController
            destination.selectedIndexPath = indexPath
            handlePushAnimate(title: title, destination: destination)
        case "Settings":
            let destination = SettingViewController()
            destination.baseController = baseController
            destination.selectedIndexPath = indexPath
            handlePushAnimate(title: title, destination: destination)
        case "Help":
            let destination = HelpViewController()
            destination.baseController = baseController
            destination.selectedIndexPath = indexPath
            handlePushAnimate(title: title, destination: destination)
        case "Log out":
            let destination = LogOutViewController()
            destination.baseController = baseController
            destination.selectedIndexPath = indexPath
            handlePushAnimate(title: title, destination: destination)
        default:
            let destination = TableViewController()
            isFirstTime = false
            destination.selectedIndexPath = indexPath
        }
    }
    
    func handlePushAnimate(title: String, destination: UIViewController) {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.menuView.frame = CGRect(x: -250, y: 0, width: 250, height: window.frame.height)
            }
            
        }) { (completion: Bool) in
            self.baseController?.navigationItem.title = title
            self.baseController?.navigationItem.largeTitleDisplayMode = .never
            self.baseController?.navigationController?.pushViewController(destination, animated: true)
        }
    }
    
    
    override init() {
        super.init()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }
}










