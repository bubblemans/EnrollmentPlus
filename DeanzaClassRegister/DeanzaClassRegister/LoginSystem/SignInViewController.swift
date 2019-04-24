//
//  SignInViewController.swift
//  DeanzaClassRegister
//
//  Created by Karen Jin on 10/8/18.
//  Copyright © 2018 Karen Jin. All rights reserved.
//

import UIKit
import SimpleCheckbox
import SVProgressHUD

var token = Token(auth_token: "")

class SignInViewController: UIViewController, UINavigationControllerDelegate, UITextFieldDelegate {
    var userLogoImageView = UIImageView()
    var keyLogoImageView = UIImageView()
    var usernameTextfield = UITextField()
    var passwordTextfield = UITextField()
    
    var isSignUpable = false
    
    let checkboxKey = "checkboxKey"
    let username = "username"
    let password = "password"
    
//    let backgroundImage: UIImageView = {
//        let view = UIImageView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
  
    let forgotPasswordButton : UIButton = {
        let bt = UIButton()
        let atr = [NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 14) as Any, NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), NSAttributedString.Key.underlineStyle: 1] as [NSAttributedString.Key : Any]
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
    
    let checkBox: Checkbox = {
        let view = Checkbox()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let signUpLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Don't have an account?"
        label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        label.textAlignment = .center
        return label
    }()
    
    let blackView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        restoreUsername()
        
        setupBackgroundImage()
        setupRectangleView()
        setupLayer()
        setupUserTF()
        setupPF()
        setupLogoView()
        setupKeyLogoView()
        setupCheckBox()
        setupSignInBT()
        setupSignLabel()
        setupSignUpBT()
        setupForgotPSButton()
        
        activateSignInBt()
    }
    
    private func restoreUsername() {
        if let ischecked = UserDefaults.standard.value(forKey: checkboxKey) as? Bool {
            checkBox.isChecked = ischecked
        }
        let usernameText = UserDefaults.standard.string(forKey: username) ?? ""
        usernameTextfield.text = usernameText
        
        let passwordText = UserDefaults.standard.string(forKey: password) ?? ""
        passwordTextfield.text = passwordText
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
        rectangleView.translatesAutoresizingMaskIntoConstraints = false
        rectangleView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
        rectangleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        rectangleView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        rectangleView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
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
    
//    let sublayer = CALayer()
    let sublayer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let whiteBoxName: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let whiteBoxKey: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private func setupLayer() {
        
        view.addSubview(sublayer)
        sublayer.backgroundColor = #colorLiteral(red: 0.9098039216, green: 0.9098039216, blue: 0.9098039216, alpha: 1)
        sublayer.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        sublayer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sublayer.heightAnchor.constraint(equalToConstant: 120).isActive = true
        sublayer.widthAnchor.constraint(equalToConstant: 120).isActive = true
        sublayer.layer.cornerRadius = 60

        
        let imageLayer = UIImageView()
        imageLayer.frame = CGRect(x: 5 , y: 5, width: 110, height: 110)
        imageLayer.layer.cornerRadius = 55
        imageLayer.image = UIImage(named:"logo.png")
//        imageLayer.clipsToBounds = true
        sublayer.addSubview(imageLayer)
        
        view.addSubview(whiteBoxName)
        whiteBoxName.backgroundColor = .white
        whiteBoxName.topAnchor.constraint(equalTo: sublayer.bottomAnchor, constant: 40).isActive = true
        whiteBoxName.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        whiteBoxName.widthAnchor.constraint(equalToConstant: 274).isActive = true
        whiteBoxName.heightAnchor.constraint(equalToConstant: 40).isActive = true
//        whiteBoxName.frame = CGRect(x: 70, y: 348, width: 274, height: 40)

        view.addSubview(whiteBoxKey)
        whiteBoxKey.backgroundColor = .white
        whiteBoxKey.topAnchor.constraint(equalTo: whiteBoxName.bottomAnchor, constant: 50).isActive = true
        whiteBoxKey.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        whiteBoxKey.widthAnchor.constraint(equalToConstant: 274).isActive = true
        whiteBoxKey.heightAnchor.constraint(equalToConstant: 40).isActive = true
//        whiteBoxKey.frame = CGRect(x: 70, y: 420, width: 274, height: 40)
    }
    
    private func setupLogoView() {
//        userLogoImageView = UIImageView(frame: CGRect(x: 80, y: 357, width: 23, height: 23))
        self.view.addSubview(userLogoImageView)
        userLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        userLogoImageView.topAnchor.constraint(equalTo: usernameTextfield.topAnchor, constant: 8).isActive = true
        userLogoImageView.trailingAnchor.constraint(equalTo: usernameTextfield.leadingAnchor, constant: -15).isActive = true
        userLogoImageView.widthAnchor.constraint(equalToConstant: 23).isActive = true
        userLogoImageView.heightAnchor.constraint(equalToConstant: 23).isActive = true
        userLogoImageView.image = UIImage(named:"userlogo.png")
    }

    private func setupKeyLogoView() {
//        keyLogoImageView = UIImageView(frame: CGRect(x: 80, y: 428, width: 23, height: 23))
        self.view.addSubview(keyLogoImageView)
        keyLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        keyLogoImageView.topAnchor.constraint(equalTo: passwordTextfield.topAnchor, constant: 8).isActive = true
        keyLogoImageView.trailingAnchor.constraint(equalTo: passwordTextfield.leadingAnchor, constant: -15).isActive = true
        keyLogoImageView.widthAnchor.constraint(equalToConstant: 23).isActive = true
        keyLogoImageView.heightAnchor.constraint(equalToConstant: 23).isActive = true
        keyLogoImageView.image = UIImage(named:"keylogo.png")
        self.view.addSubview(keyLogoImageView)
    }
    
    private func setupUserTF() {
//        usernameTextfield.frame = CGRect(x: 114, y: 350, width: 224, height: 40)
        self.view.addSubview(usernameTextfield)
        usernameTextfield.translatesAutoresizingMaskIntoConstraints = false
        usernameTextfield.topAnchor.constraint(equalTo: sublayer.bottomAnchor, constant: 40).isActive = true
        usernameTextfield.centerXAnchor.constraint(equalTo: rectangleView.centerXAnchor, constant: 20).isActive = true
        usernameTextfield.widthAnchor.constraint(equalToConstant: 224).isActive = true
        usernameTextfield.heightAnchor.constraint(equalToConstant: 40).isActive = true
        usernameTextfield.placeholder = "Username"
        usernameTextfield.layer.cornerRadius = 20
        usernameTextfield.autocorrectionType = .no
        usernameTextfield.autocapitalizationType = .none
        usernameTextfield.clearButtonMode = .whileEditing
        usernameTextfield.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    private func setupPF() {
//        passwordTextfield.frame = CGRect(x: 114, y: 420, width: 224, height: 40)
        self.view.addSubview(passwordTextfield)
        passwordTextfield.delegate = self
        passwordTextfield.translatesAutoresizingMaskIntoConstraints = false
        passwordTextfield.topAnchor.constraint(equalTo: whiteBoxName.bottomAnchor, constant: 50).isActive = true
        passwordTextfield.centerXAnchor.constraint(equalTo: rectangleView.centerXAnchor, constant: 20).isActive = true
        passwordTextfield.widthAnchor.constraint(equalToConstant: 224).isActive = true
        passwordTextfield.heightAnchor.constraint(equalToConstant: 40).isActive = true
        passwordTextfield.placeholder = "Password"
        passwordTextfield.layer.cornerRadius = 20
        passwordTextfield.autocapitalizationType = .none
        passwordTextfield.autocorrectionType = .no
        passwordTextfield.clearButtonMode = .whileEditing
        passwordTextfield.isSecureTextEntry = true
        passwordTextfield.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    private func setupSignInBT() {
        view.addSubview(signInButton)
        signInButton.isUserInteractionEnabled = false
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.layer.cornerRadius = 40 / 2
        signInButton.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        signInButton.setTitleColor(UIColor.white, for: .normal)
        signInButton.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        
        signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signInButton.topAnchor.constraint(equalTo: rememberMeButton.topAnchor, constant: 60).isActive = true
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
        signUpButton.topAnchor.constraint(equalTo: signUpLabel.bottomAnchor, constant: 5).isActive = true
        signUpButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        signUpButton.widthAnchor.constraint(equalToConstant: 274).isActive = true
    }
    
    private func setupCheckBox() {
        checkBox.checkmarkStyle = .tick
        checkBox.useHapticFeedback = true
        checkBox.checkedBorderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        checkBox.uncheckedBorderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        checkBox.checkmarkColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        checkBox.addTarget(self, action: #selector(checkboxValueChanged(sender:)), for: .valueChanged)
        view.addSubview(checkBox)
        checkBox.topAnchor.constraint(equalTo: passwordTextfield.bottomAnchor, constant: 40).isActive = true
        checkBox.leadingAnchor.constraint(equalTo: userLogoImageView.leadingAnchor, constant: 0).isActive = true
        checkBox.heightAnchor.constraint(equalToConstant: 20).isActive = true
        checkBox.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        view.addSubview(rememberMeButton)
        rememberMeButton.topAnchor.constraint(equalTo: passwordTextfield.bottomAnchor, constant: 35).isActive = true
        rememberMeButton.leadingAnchor.constraint(equalTo: passwordTextfield.leadingAnchor, constant: -15).isActive = true
        rememberMeButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        rememberMeButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
    }
    
    private func setupSignLabel() {
        view.addSubview(signUpLabel)
        signUpLabel.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 2).isActive = true
        signUpLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signUpLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        signUpLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        handleSignIn()
        return true
    }
    
    @objc private func textDidChange() {
        saveUser()
        activateSignInBt()
    }
    
    private func activateSignInBt() {
        if usernameTextfield.text!.count != 0 && passwordTextfield.text!.count != 0 {
            isSignUpable = true
            signInButton.isUserInteractionEnabled = true
            signInButton.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.7607843137, blue: 0.1882352941, alpha: 1)
        } else {
            isSignUpable = false
            signInButton.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            signInButton.isUserInteractionEnabled = false
        }
    }
    
    @objc private func checkboxValueChanged(sender: Checkbox) {
        saveUser()
    }
    
    @objc private func handleRememberMe() {
        checkBox.isChecked = !checkBox.isChecked
        saveUser()
    }
    
    func saveUser() {
        if checkBox.isChecked == true {
            UserDefaults.standard.set(checkBox.isChecked, forKey: checkboxKey)
            UserDefaults.standard.set(usernameTextfield.text, forKey: username)
            UserDefaults.standard.set(passwordTextfield.text, forKey: password)
        } else {
            UserDefaults.standard.removeObject(forKey: checkboxKey)
            UserDefaults.standard.removeObject(forKey: username)
            UserDefaults.standard.removeObject(forKey: password)
        }
    }
    
    
    
    @objc private func handleForgetPassword() {
        let vc = ForgetPasswordViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc private func handleSignUp() {
        let destination = SignUpVC()
        self.present(destination, animated: true, completion: nil)
    }
    
    @objc func handleSignIn() {
        email = usernameTextfield.text
        oldPassword = passwordTextfield.text
        
        saveUser()
        
        if let window = UIApplication.shared.keyWindow {
            SVProgressHUD.show(withStatus: "Loading...")
            SVProgressHUD.setBackgroundColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
            
            window.addSubview(blackView)
            self.blackView.alpha = 0.5
            blackView.frame = CGRect(x: 0, y: 0, width: window.frame.width, height: window.frame.height)
            
            let user = User()
            user.email = usernameTextfield.text
            user.password = passwordTextfield.text
            
            let info = Information(user: user)
            let userJson = try! JSONEncoder().encode(info)
            
            // post
            let postUrlString = "https://api.enrollment.plus/signin"
            guard let url = URL(string: postUrlString) else { return }
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = userJson
            
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if error != nil {
                    if error?._code == NSURLErrorTimedOut {
                        DispatchQueue.main.async {
                            let alert = UIAlertController(title: "Poor Connection...", message: "", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: nil))
                            self.present(alert, animated: true)
                            print ("server error when sign in")
                            SVProgressHUD.dismiss()
                            self.blackView.alpha = 0
                        }
                    }
                    return
                }
                
                if let response = response as? HTTPURLResponse,
                    (200...299).contains(response.statusCode) != true{
                    guard let data = data else { return }
                    print(response)
                    var message = WrongMessage()
                    message = try! JSONDecoder().decode(WrongMessage.self, from: data)
                    
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Please try again!", message: message.error, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
                        self.present(alert, animated: true)
                        
                        print ("server error when sign in")
                        SVProgressHUD.dismiss()
                        self.blackView.alpha = 0
                    }
                    return
                }
                
                if let mimeType = response!.mimeType,
                    mimeType == "application/json",
                    let data = data {
                    DispatchQueue.main.async {
                        token = try! JSONDecoder().decode(Token.self, from: data)
                        SVProgressHUD.dismiss()
                        self.blackView.alpha = 0
                        let tabVC = TabBarController()
                        self.present(tabVC, animated: true, completion: nil)
                    }
                }
            }.resume()
        }
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}




