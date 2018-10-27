//
//  SignInViewController.swift
//  DeanzaClassRegister
//
//  Created by Karen Jin on 10/8/18.
//  Copyright © 2018 Karen Jin. All rights reserved.
//

import UIKit
import SimpleCheckbox

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
        let atr = [NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 14), NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), NSAttributedString.Key.underlineStyle: 1] as [NSAttributedString.Key : Any]
        let btTitleStr = NSMutableAttributedString(string: "Forgot Password?", attributes: atr)
        
        bt.setAttributedTitle(btTitleStr, for: .normal)
        bt.translatesAutoresizingMaskIntoConstraints = false
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
    
    let rememberMeButton: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.setTitle("Remember Me", for: .normal)
        bt.setTitleColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), for: .normal)
        bt.backgroundColor = .clear
        bt.contentHorizontalAlignment = .left
        bt.addTarget(self, action: #selector(handleRememberMe), for: .touchUpInside)
        return bt
    }()
    
    let checkBox = Checkbox(frame: CGRect(x: 70, y: 500, width: 20, height: 20))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackgroundImage()
        setupRectangleView()
        setupLayer()
        setupLogoView()
        setupKeyLogoView()
        setupUserTF()
        setupPF()
        setupSignInBT()
        setupSignUpBT()
        setupForgotPSButton()
        setupCheckBox()
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
        view.addSubview(rectangleView)
        rectangleView.frame = CGRect(x: 34, y: 246, width: 346, height: 517)
        rectangleView.layer.cornerRadius = 21
        rectangleView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        rectangleView.layer.shadowOpacity = 0.5
        rectangleView.layer.shadowOffset = CGSize.zero
        rectangleView.layer.shadowRadius = 21
        rectangleView.layer.shadowPath = UIBezierPath(rect: rectangleView.bounds).cgPath
        rectangleView.layer.shouldRasterize = true
    }
    
    private func setupForgotPSButton() {
        view.addSubview(forgotPasswordButton)
        forgotPasswordButton.topAnchor.constraint(equalTo: passwordTextfield.bottomAnchor, constant: 5).isActive = true
        forgotPasswordButton.trailingAnchor.constraint(equalTo: passwordTextfield.trailingAnchor).isActive = true
        forgotPasswordButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        forgotPasswordButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        
        forgotPasswordButton.addTarget(self, action: #selector(handleForgetPassword), for: .touchUpInside)
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
        view.addSubview(signInButton)
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.layer.cornerRadius = 40 / 2
        signInButton.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.7607843137, blue: 0.1882352941, alpha: 1)
        signInButton.setTitleColor(UIColor.white, for: .normal)
        signInButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        
        signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signInButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 600).isActive = true
        signInButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        signInButton.widthAnchor.constraint(equalToConstant: 274).isActive = true
    }
    
    private func setupSignUpBT() {
        view.addSubview(signUpButton)
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.layer.cornerRadius = 40 / 2
        signUpButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        signUpButton.setTitleColor(#colorLiteral(red: 0.4078431373, green: 0.007843137255, blue: 0.1490196078, alpha: 1), for: .normal)
        signUpButton.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
    
        signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signUpButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 670).isActive = true
        signUpButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        signUpButton.widthAnchor.constraint(equalToConstant: 274).isActive = true
    }
    
    private func setupCheckBox() {
        checkBox.checkmarkStyle = .tick
        checkBox.useHapticFeedback = true
        checkBox.checkedBorderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        checkBox.uncheckedBorderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        checkBox.checkmarkColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        checkBox.addTarget(self, action: #selector(handleRememberMe), for: .touchUpInside)
        view.addSubview(checkBox)
        
        view.addSubview(rememberMeButton)
        rememberMeButton.topAnchor.constraint(equalTo: passwordTextfield.bottomAnchor, constant: 35).isActive = true
        rememberMeButton.leadingAnchor.constraint(equalTo: passwordTextfield.leadingAnchor, constant: -15).isActive = true
        rememberMeButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        rememberMeButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
    }
    
    @objc private func handleRememberMe() {
        print("remember me")
        checkBox.isChecked = !checkBox.isChecked
    }
    
    @objc private func handleForgetPassword() {
        print("forget password")
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
