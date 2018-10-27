//
//  SignInViewController.swift
//  DeanzaClassRegister
//
//  Created by Karen Jin on 10/8/18.
//  Copyright © 2018 Karen Jin. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController, UINavigationControllerDelegate {
    var userLogoImageView: UIImageView!
    var keyLogoImageView: UIImageView!
    var usernameTextfield = UITextField()
    var passwordTextfield = UITextField()
    
    let backgroundImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
  
    let forgotPasswordButton : UIButton = {
        let bt = UIButton()
        bt.setTitle("Forgot Password?", for: .normal)
        bt.setTitleColor(#colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1), for: .normal)
        bt.titleLabel?.font = UIFont(name: "Helvetica", size: 12)
//        bt.underline()
        return bt
    }()

    let rectangleView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9098039216, green: 0.9098039216, blue: 0.9098039216, alpha: 1)
        return view
    }()
    
    let signInButton: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        return bt
    }()
    
    let signUpButton: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        return bt
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackgroundImage()
        setupRectangleView()
        setupForgotPSLabel()
        setupLayer()
        setupLogoView()
        setupKeyLogoView()
        setupUserTF()
        setupPF()
        setupSignInBT()
        setupSignUpBT()
    }
    
    private func setupBackgroundImage() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "best-poly-backgrounds.png")
        backgroundImage.contentMode = .scaleAspectFill
        self.view.addSubview(backgroundImage)
        backgroundImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backgroundImage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        backgroundImage.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        backgroundImage.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    private func setupRectangleView() {
        backgroundImage.addSubview(rectangleView)
        rectangleView.frame = CGRect(x: 34, y: 246, width: 346, height: 517)
        rectangleView.layer.cornerRadius = 21
        rectangleView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        rectangleView.layer.shadowOpacity = 0.5
        rectangleView.layer.shadowOffset = CGSize.zero
        rectangleView.layer.shadowRadius = 21
        rectangleView.layer.shadowPath = UIBezierPath(rect: rectangleView.bounds).cgPath
        rectangleView.layer.shouldRasterize = true
    }
    
    private func setupForgotPSLabel() {
        self.view.addSubview(forgotPasswordButton)
        forgotPasswordButton.frame = CGRect(x: 220, y: 480, width: self.view.frame.width, height: 40)
    }
    
    private func setupLayer() {
        let sublayer = CALayer()
        sublayer.backgroundColor = #colorLiteral(red: 0.9098039216, green: 0.9098039216, blue: 0.9098039216, alpha: 1)
        
        sublayer.frame = CGRect(x: 150, y: 180, width: 120, height: 120)
        sublayer.cornerRadius = sublayer.frame.width / 2
        
        self.view.layer.addSublayer(sublayer)
        
        let imageLayer = CALayer()
        imageLayer.frame = CGRect(x: 5 , y: 5, width: 110, height: 110)
        imageLayer.cornerRadius = imageLayer.bounds.width / 2
        imageLayer.contents = UIImage(named:"logo.png")?.cgImage
        imageLayer.masksToBounds = true
        sublayer.addSublayer(imageLayer)
        
        let whiteBoxName = CALayer()
        whiteBoxName.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        whiteBoxName.frame = CGRect(x: 70, y: 348, width: 274, height: 40)
        self.view.layer.addSublayer(whiteBoxName)
        
        let whiteBoxKey = CALayer()
        whiteBoxKey.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        whiteBoxKey.frame = CGRect(x: 70, y: 420, width: 274, height: 40)
        self.view.layer.addSublayer(whiteBoxKey)
    }
    
    private func setupLogoView() {
        userLogoImageView = UIImageView(frame: CGRect(x: 80, y: 357, width: 23, height: 23))
        userLogoImageView.image = UIImage(named:"userlogo.png")
        self.view.addSubview(userLogoImageView)
    }

    private func setupKeyLogoView() {
        keyLogoImageView = UIImageView(frame: CGRect(x: 80, y: 428, width: 23, height: 23))
        keyLogoImageView.image = UIImage(named:"keylogo.png")
        self.view.addSubview(keyLogoImageView)
    }
    
    private func setupUserTF() {
        usernameTextfield.frame = CGRect(x: 114, y: 350, width: 224, height: 40)
        usernameTextfield.placeholder = "Username"
        usernameTextfield.layer.cornerRadius = 20
        self.view.addSubview(usernameTextfield)
    }
    
    private func setupPF() {
        passwordTextfield.frame = CGRect(x: 114, y: 420, width: 224, height: 40)
        passwordTextfield.placeholder = "Password"
        passwordTextfield.layer.cornerRadius = 20
        self.view.addSubview(passwordTextfield)
    }
    
    private func setupSignInBT() {
        signInButton.frame = CGRect(x: 70.0, y: 590.0, width: 274.0, height: 40.0)
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.layer.cornerRadius = signInButton.frame.height / 2
        signInButton.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.7607843137, blue: 0.1882352941, alpha: 1)
        signInButton.setTitleColor(UIColor.white, for: .normal)
        signInButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        backgroundImage.addSubview(signInButton)
    }
    
    private func setupSignUpBT() {
        signUpButton.frame = CGRect(x: 70.0, y: 670.0, width: 274.0, height: 40.0)
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.layer.cornerRadius = signUpButton.frame.height / 2
        signUpButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        signUpButton.setTitleColor(#colorLiteral(red: 0.4078431373, green: 0.007843137255, blue: 0.1490196078, alpha: 1), for: .normal)
        signUpButton.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        self.view.addSubview(signUpButton)
    }
    
    @objc private func handleSignUp() {
        
        let destination = PageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.present(destination, animated: true, completion: nil)
    }
    
    @objc func buttonClicked(){
         print("Button is Clicked")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
