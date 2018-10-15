//
//  PhotoOptionTableView.swift
//  DeanzaClassRegister
//
//  Created by Alvin Lin on 2018/10/14.
//  Copyright © 2018 Alvin Lin. All rights reserved.
//

import UIKit

class PhotoOptionTableView: UITableView, UITableViewDataSource, UITableViewDelegate  {
    let photoOptions = ["Choose from Library...", "Take Photo...", "Cancel"]
    let cellId = "cellId"
    var baseController: EditProfileController?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.9372549057, blue: 0.9568627477, alpha: 1)
        cell.textLabel?.text = photoOptions[indexPath.row]
        cell.textLabel?.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        cell.textLabel?.textAlignment = .center
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if indexPath == IndexPath(row: 0, section: 0) {
//            photoLibrary()
//            photoOptionsView.reloadData()
//        } else if indexPath == IndexPath(row: 1, section: 0) {
//            camera()
//            photoOptionsView.reloadData()
//        } else {
//            cancel()
//            photoOptionsView.reloadData()
//        }
//    }
    
    func cancel() {
        if let window = UIApplication.shared.keyWindow {
            UIView.animate(withDuration: 0.5) {
                let width = CGFloat(window.frame.width - 20)
                let height = CGFloat(150)
                
//                self.photoOptionsView.frame = CGRect(x: (window.frame.width - width) / 2, y: window.frame.height, width: width, height: height)
            }
        }
    }
    
//    func photoLibrary() {
//        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
//            let imagePicker = UIImagePickerController()
//            imagePicker.sourceType = .photoLibrary
//            imagePicker.delegate = self
//            imagePicker.allowsEditing = true
//            baseController?.present(imagePicker, animated: true, completion: nil)
//
//            if let window = UIApplication.shared.keyWindow {
////                blackView.alpha = 0
//                UIView.animate(withDuration: 0.5) {
//                    let width = CGFloat(window.frame.width - 20)
//                    let height = CGFloat(150)
//
//                    self.photoOptionsView.frame = CGRect(x: (window.frame.width - width) / 2, y: window.frame.height, width: width, height: height)
//                }
//            }
//        } else {
//            print("The photo library is not available.")
//        }
//    }
//
//    func camera() {
//        if UIImagePickerController.isSourceTypeAvailable(.camera) {
//            let imagePicker = UIImagePickerController()
//            imagePicker.sourceType = .camera
//            imagePicker.cameraDevice = .front
//            imagePicker.delegate = self
//            imagePicker.allowsEditing = true
//            baseController?.present(imagePicker, animated: true, completion: nil)
//        } else {
//            print("The camera is not available.")
//        }
//    }
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        // Local variable inserted by Swift 4.2 migrator.
//        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
//        
//        
//        if let image = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.editedImage)] {
//            userImage = image as! UIImage
//            profileView.image = userImage
//            picker.dismiss(animated: true, completion: nil)
//        } else {
//            // TODO: alert
//            print("No image found.")
//        }
//    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        dataSource = self
        delegate = self
        register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
