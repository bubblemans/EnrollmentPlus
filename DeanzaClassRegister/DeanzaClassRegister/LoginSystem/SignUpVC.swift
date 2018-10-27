//
//  SignupUsernameViewController.swift
//  DeanzaClassRegister
//
//  Created by Karen Jin on 10/15/18.
//  Copyright © 2018 Alvin Lin. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {
    
    // Username Textfield
    let usernameTextfield : UITextField = {
        let userTextfield = UITextField()
        userTextfield.attributedPlaceholder = NSAttributedString(string:"  Username ",attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        userTextfield.backgroundColor = #colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 0.5)
        userTextfield.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        userTextfield.borderStyle = UITextField.BorderStyle.roundedRect
        userTextfield.autocorrectionType = UITextAutocorrectionType.no
        userTextfield.keyboardType = UIKeyboardType.default
        userTextfield.returnKeyType = UIReturnKeyType.done
        userTextfield.clearButtonMode = UITextField.ViewMode.whileEditing
        userTextfield.autocapitalizationType = .none
        return userTextfield
    } ()
    
    let passwordTextfield : UITextField = {
        let passTextfield = UITextField()
        passTextfield.attributedPlaceholder = NSAttributedString(string:"  Password ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        passTextfield.backgroundColor = #colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 0.5)
        passTextfield.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        passTextfield.borderStyle = UITextField.BorderStyle.roundedRect
        passTextfield.autocorrectionType = UITextAutocorrectionType.no
        passTextfield.keyboardType = UIKeyboardType.default
        passTextfield.returnKeyType = UIReturnKeyType.done
        passTextfield.clearButtonMode = UITextField.ViewMode.whileEditing
        passTextfield.autocapitalizationType = .none
        passTextfield.isSecureTextEntry = true
        return passTextfield
    }()
    
    let phoneTextField: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.autocapitalizationType = .none
        view.autocorrectionType = .no
        return view
    }()
    
    
    
    let signUpButton : UIButton = {
        let bt = UIButton()
        bt.setTitle("Done", for: .normal)
        bt.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        bt.setTitleColor(#colorLiteral(red: 0.4078431373, green: 0.007843137255, blue: 0.1490196078, alpha: 1), for: .normal)
        return bt
        
    }()
    
    let backButton: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        return bt
    }()

    let imageView : UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "imageView-grey-background_people.png")
        imgView.layer.borderWidth = 4
        imgView.layer.masksToBounds = false
        imgView.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        imgView.clipsToBounds = true
        return imgView
    }()
    
    let addPicButton : UIButton = {
        let picButton = UIButton()
        picButton.setBackgroundImage(UIImage(named:"upload_your_profile_picture_camera.png"), for: .normal)
        return picButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        // background Image
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "best-poly-backgrounds.png")
        backgroundImage.contentMode = .scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        // background color
        self.view.backgroundColor = #colorLiteral(red: 0.4078431373, green: 0.007843137255, blue: 0.1490196078, alpha: 0.5)
        
        setProfileImageView()
        setupUserTextfield()
        setupPassTextfield()
        setupSignupBt()
        setUpAddPicButton()
        setupBackButton()
        
    }
    
    // Autolayout must use below this way to make UIImageView round
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        imageView.layer.cornerRadius = imageView.frame.height / 2
    }
    
    private func setupUserTextfield() {
        self.view.addSubview(usernameTextfield)
        usernameTextfield.translatesAutoresizingMaskIntoConstraints = false
        usernameTextfield.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        usernameTextfield.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 370).isActive = true
        usernameTextfield.widthAnchor.constraint(equalToConstant: 250).isActive = true
        usernameTextfield.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func setupPassTextfield() {
        self.view.addSubview(passwordTextfield)
        passwordTextfield.translatesAutoresizingMaskIntoConstraints = false
        passwordTextfield.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        passwordTextfield.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 450).isActive = true
        passwordTextfield.widthAnchor.constraint(equalToConstant: 250).isActive = true
        passwordTextfield.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func setupSignupBt(){
        let height = CGFloat(40)
        self.view.addSubview(signUpButton)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        signUpButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 550).isActive = true
        signUpButton.widthAnchor.constraint(equalToConstant: 274).isActive = true
        signUpButton.heightAnchor.constraint(equalToConstant: height).isActive = true
        signUpButton.layer.cornerRadius = height / 2
    }
    
    private func setupBackButton() {
        self.view.addSubview(backButton)
        backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 550).isActive = true
        backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 274).isActive = true
        backButton.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
    }
    
    private func setProfileImageView(){
        self.view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 150).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        imageView.heightAnchor.constraint(equalToConstant:150).isActive = true
    }
    
    private func setUpAddPicButton(){
        self.view.addSubview(addPicButton)
        addPicButton.translatesAutoresizingMaskIntoConstraints = false
        addPicButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 230).isActive = true
        addPicButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 260).isActive = true
        addPicButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        addPicButton.heightAnchor.constraint(equalToConstant:50).isActive = true
    }
}





