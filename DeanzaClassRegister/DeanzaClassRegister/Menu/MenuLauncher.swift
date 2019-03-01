//
//  MenuLauncher.swift
//  DeanzaClassRegister
//
//  Created by Alvin Lin on 2018/9/12.
//  Copyright © 2018 Alvin Lin. All rights reserved.
//

import UIKit
import SVProgressHUD

var userImage = UIImage(named: "user")?.withRenderingMode(.alwaysTemplate)

class MenuLauncher: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    let photoOptions = ["Choose from Library...", "Take Photo...", "Cancel"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoOptions.count
    }
    
    private let cellIdForTableView = "cellIdForTableView"
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdForTableView, for: indexPath)
        cell.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.9372549057, blue: 0.9568627477, alpha: 1)
        cell.textLabel?.text = photoOptions[indexPath.row]
        cell.textLabel?.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        cell.textLabel?.textAlignment = .center
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath == IndexPath(row: 0, section: 0) {
            photoLibrary()
            photoOptionsView.reloadData()
        } else if indexPath == IndexPath(row: 1, section: 0) {
            camera()
            photoOptionsView.reloadData()
        } else {
            cancel()
            photoOptionsView.reloadData()
        }
    }
    
    
    
    private let cellId = "cellId"
    let labelString = ["Home", "MyList", "Notification", "Settings", "Help", "Log out"]
    let imageString = ["home", "shoppingList", "mail", "settings", "information", "logout"]
    var baseController: TableViewController?
    
    let menuView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    lazy var profileView: UIImageView = {
        let view = UIImageView()
//        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = userImage
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
    
    let photoOptionsView: UITableView = {
        let view = UITableView()
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        view.layer.cornerRadius = 10
        return view
    }()
    
    open func showMenu() {
        
        if let window = UIApplication.shared.keyWindow {
            // blackView
            window.addSubview(blackView)
            blackView.alpha = 0.5
            blackView.frame = CGRect(x: 0, y: 0, width: window.frame.width, height: window.frame.height)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismissMenu)))
            
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
            profileView.contentMode = .scaleToFill
            profileView.clipsToBounds = true
            profileView.tintColor = .black
            
            // imageButton
            menuView.addSubview(imageButton)
            imageButton.frame = CGRect(x: profileView.frame.origin.x + profileView.frame.width - 50, y: profileView.frame.origin.y + profileView.frame.height - 50, width: 50, height: 50)
            imageButton.setImage(UIImage(named: "camera"), for: UIControl.State())
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
        if let window = UIApplication.shared.keyWindow {
            let width = CGFloat(window.frame.width - 20)
            let height = CGFloat(150)
            
            photoOptionsView.frame = CGRect(x: (window.frame.width - width) / 2, y: window.frame.height, width: width, height: height)
            UIView.animate(withDuration: 0.5) {
                // blackView
                window.addSubview(self.blackView)
                self.blackView.alpha = 0.5
                self.blackView.frame = CGRect(x: 0, y: 0, width: window.frame.width, height: window.frame.height)
                self.blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleDismissPhotoOptions)))
                
                // photoOptionsCollectionView
                window.addSubview(self.photoOptionsView)
                self.photoOptionsView.frame = CGRect(x: (window.frame.width - width) / 2, y: window.frame.height - height - 20, width: width, height: height)
            }
        }
    }
    
    @objc func handleDismissPhotoOptions() {
        cancel()
    }
    
    func photoLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            handleDismissMenu()
            baseController?.present(imagePicker, animated: true, completion: nil)
            
            if let window = UIApplication.shared.keyWindow {
                blackView.alpha = 0
                UIView.animate(withDuration: 0.5) {
                    let width = CGFloat(window.frame.width - 20)
                    let height = CGFloat(150)
                    
                    self.photoOptionsView.frame = CGRect(x: (window.frame.width - width) / 2, y: window.frame.height, width: width, height: height)
                }
            }
        } else {
            print("The photo library is not available.")
        }
    }
    
    func camera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .camera
            imagePicker.cameraDevice = .front
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            handleDismissMenu()
            baseController?.present(imagePicker, animated: true, completion: nil)
        } else {
            print("The camera is not available.")
        }
    }
    
    func cancel() {
        if let window = UIApplication.shared.keyWindow {
            handleDismissMenu()
            UIView.animate(withDuration: 0.5) {
                let width = CGFloat(window.frame.width - 20)
                let height = CGFloat(150)
                
                self.photoOptionsView.frame = CGRect(x: (window.frame.width - width) / 2, y: window.frame.height, width: width, height: height)
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Local variable inserted by Swift 4.2 migrator.
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

        
        if let image = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.editedImage)] {
            userImage = image as? UIImage
            profileView.image = userImage
            picker.dismiss(animated: true, completion: nil)
        } else {
            // TODO: alert
            print("No image found.")
        }
    }
    
    @objc func handleDismissMenu() {
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
        
        
        switch labelString[indexPath.row] {
        case "Home":
            handlePopAnimate()
        case "MyList":
            let destination = MyListViewController()
            destination.baseController = baseController
            destination.selectedIndexPath = indexPath
            handlePushAnimate(title: title, destination: destination)
        case "Notification":
            let destination = NotificationViewController()
            destination.baseController = baseController
            destination.selectedIndexPath = indexPath
            downloadNoti(title: title, destination: destination)
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
            let destination = SignInViewController()
            baseController?.present(destination, animated: true, completion: {
                DispatchQueue.main.async {
                    UIView.animate(withDuration: 0.5, animations: {
                        self.blackView.alpha = 0
                        if let window = UIApplication.shared.keyWindow {
                            self.menuView.frame = CGRect(x: -250, y: 0, width: 250, height: window.frame.height)
                        }
                    })
                    token = Token(auth_token: "")
                    self.baseController?.navigationController?.popToRootViewController(animated: false)
                }
            })
        default:
            let destination = TableViewController()
            isFirstTime = false
            destination.selectedIndexPath = indexPath
        }
    }
    
    func downloadNoti(title: String, destination: UIViewController) {
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 1
            SVProgressHUD.show(withStatus: "Loading...")
            SVProgressHUD.setBackgroundColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
            
            // http get request
            let urlString = "https://api.daclassplanner.com/user/notifications"
            guard let url = URL(string: urlString) else { return }
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.setValue(token.auth_token, forHTTPHeaderField: "Authorization")
            
            URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                if let error = error {
                    print(error)
                    return
                }
                
                if let response = response {
                    print(response)
                } else {
                    print("no response")
                }
                

                if let data = data {
                    DispatchQueue.main.async {
//                                let decoder = JSONDecoder()
//                                let dateFormatter = DateFormatter()
//                                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z''\'                 "
//                                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                        
                        notiDatas = try! JSONDecoder().decode([Notifications].self, from: data)
                    }
                } else {
                    print("no data")
                }
                
                DispatchQueue.main.async {
                    SVProgressHUD.dismiss()
                    self.blackView.alpha = 0
                    self.handlePushAnimate(title: title, destination: destination)
                }
                
            }).resume()
        }
    }
    
    func handlePopAnimate() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.menuView.frame = CGRect(x: -250, y: 0, width: 250, height: window.frame.height)
            }
            
        }) { (completion: Bool) in
            self.baseController?.navigationItem.title = "Classes"
            self.baseController?.navigationItem.largeTitleDisplayMode = .always
            self.baseController?.navigationController?.popToRootViewController(animated: true)
            self.baseController?.navigationController?.navigationBar.barTintColor = .white
            self.baseController?.navigationController?.navigationBar.tintColor = .black
            self.baseController?.definesPresentationContext = false
            self.baseController?.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
            self.baseController?.navigationController?.navigationBar.prefersLargeTitles = true
            self.baseController?.navigationItem.hidesSearchBarWhenScrolling = false
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
            self.baseController?.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.3771604213, green: 0.6235294342, blue: 0.57437459, alpha: 1)
            self.baseController?.navigationController?.navigationBar.tintColor = .white
            self.baseController?.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        }
    }
    
    
    override init() {
        super.init()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        photoOptionsView.dataSource = self
        photoOptionsView.delegate = self
        photoOptionsView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdForTableView)
    }
}











// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}
