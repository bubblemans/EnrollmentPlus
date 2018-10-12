//
//  SignInViewController.swift
//  DeanzaClassRegister
//
//  Created by Karen Jin on 10/8/18.
//  Copyright © 2018 Karen Jin. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    var imageView: UIImageView!
    var userLogoImageView: UIImageView!
    var keyLogoImageView: UIImageView!
    var label = UILabel()
    var usernameTextfield = UITextField()
    var passwordTextfield = UITextField()
  //  var forgotPasswordLabel = UILabel()
    var forgotPasswordLabel : UILabel!{
        didSet{
            // Create forget password label
            forgotPasswordLabel.frame = CGRect(x: 220, y: 480, width: self.view.frame.width, height: 40)
            forgotPasswordLabel.text = "Forgot Password?"
            forgotPasswordLabel.textColor = #colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1)
            forgotPasswordLabel.font = UIFont(name: "Helvetica", size: 12)
            forgotPasswordLabel.underline()
            self.view.addSubview(forgotPasswordLabel)
        }
    }

    
    
    let rectangleView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9098039216, green: 0.9098039216, blue: 0.9098039216, alpha: 1)
        return view
    }() // Why didn't put it in viewDidLoad
    
//    let circleView: UIView = {
//        let viewC = UIView()
//        viewC.backgroundColor = #colorLiteral(red: 0.9098039216, green: 0.9098039216, blue: 0.9098039216, alpha: 1)
//        return viewC
//    } ()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
/*
        // Add a grey circle under the logo to make a grey stroke and shadow effect
        greyCircle.backgroundColor = #colorLiteral(red: 0.9098039216, green: 0.9098039216, blue: 0.9098039216, alpha: 1)
        //        sublayer.shadowOffset = CGSize(width: 3, height: 3)
        greyCircle.frame = CGRect(x: 150, y: 180, width: 120, height: 120)
        greyCircle.borderColor = #colorLiteral(red: 0.9098039216, green: 0.9098039216, blue: 0.9098039216, alpha: 1)
        greyCircle.borderWidth = 5.0
        greyCircle.cornerRadius = 60
        //        sublayer.cornerRadius = sublayer.bounds.width / 2
        self.view.layer.addSublayer(greyCircle)
*/
        
        // Below Code Make a grey rectangle with round corner
        view.addSubview(rectangleView)
        rectangleView.frame = CGRect(x: 34, y: 246, width: 346, height: 517)
        rectangleView.layer.cornerRadius = 21
        rectangleView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        rectangleView.layer.shadowOpacity = 0.5
        rectangleView.layer.shadowOffset = CGSize.zero
        rectangleView.layer.shadowRadius = 21
        rectangleView.layer.shadowPath = UIBezierPath(rect: rectangleView.bounds).cgPath
        rectangleView.layer.shouldRasterize = true
/*
        // Below Code make a image with a grey inner border
        imageView = UIImageView(frame: CGRect(x: 120, y: 200, width: 100, height: 100))
        imageView.image = UIImage(named:"logo.png")
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 6
        imageView.layer.borderColor = #colorLiteral(red: 0.9098039216, green: 0.9098039216, blue: 0.9098039216, alpha: 1)
        imageView.layer.cornerRadius = imageView.bounds.width / 2
        
        imageView.contentMode = .scaleAspectFit
        self.view.addSubview(imageView)
*/
        
        // Below Code Use CALayer make a grey circle shape with a grey border
        let sublayer = CALayer()
        sublayer.backgroundColor = #colorLiteral(red: 0.9098039216, green: 0.9098039216, blue: 0.9098039216, alpha: 1)
//        sublayer.shadowOffset = CGSize(width: 3, height: 3)
        sublayer.frame = CGRect(x: 150, y: 180, width: 120, height: 120)
        sublayer.borderColor = #colorLiteral(red: 0.9098039216, green: 0.9098039216, blue: 0.9098039216, alpha: 1)
        sublayer.borderWidth = 5.0
        sublayer.cornerRadius = 60
//        sublayer.cornerRadius = sublayer.bounds.width / 2
        self.view.layer.addSublayer(sublayer)
        
        let imageLayer = CALayer()
        imageLayer.frame = sublayer.bounds
        imageLayer.cornerRadius = sublayer.bounds.width / 2
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
        
        userLogoImageView = UIImageView(frame: CGRect(x: 80, y: 357, width: 23, height: 23))
        userLogoImageView.image = UIImage(named:"userlogo.png")
        
/*
        // center the image
        userLogoImageView.contentMode = .scaleAspectFit
*/
        self.view.addSubview(userLogoImageView)
        
        keyLogoImageView = UIImageView(frame: CGRect(x: 80, y: 428, width: 23, height: 23))
        keyLogoImageView.image = UIImage(named:"keylogo.png")

        self.view.addSubview(keyLogoImageView)

/*
        // Create UILabel
        label.frame = CGRect(x: 0, y:100, width: self.view.frame.width, height:120 )
        label.text = "Welcome to De Anza Class Register App"
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.darkGray
        label.font = UIFont(name: "Helvetica", size: 22)
        
        self.view.addSubview(label)
 */
        // Create Textfield placeholder For username
        usernameTextfield.frame = CGRect(x: 114, y: 350, width: 224, height: 40)
        usernameTextfield.placeholder = "Username"
        
        self.view.addSubview(usernameTextfield)
        
        // Create Textfield placeholder for password
        passwordTextfield.frame = CGRect(x: 114, y: 420, width: 224, height: 40)
        passwordTextfield.placeholder = "Password"
        
        self.view.addSubview(passwordTextfield)
        
        let signInButton = UIButton.init(type: .system)
        signInButton.frame = CGRect(x: 70.0, y: 590.0, width: 274.0, height: 40.0)
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.layer.cornerRadius = signInButton.frame.height / 2
        // code for border line of button
//        signInButton.layer.borderWidth = 1.0
//        signInButton.layer.borderColor = UIColor.white.cgColor
        signInButton.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.7607843137, blue: 0.1882352941, alpha: 1)
        signInButton.setTitleColor(UIColor.white, for: .normal)
        signInButton.addTarget(self, action: #selector(buttonClicked(_ :)), for: .touchUpInside)
        self.view.addSubview(signInButton)
        
        let signUpButton = UIButton.init(type: .system)
        signUpButton.frame = CGRect(x: 70.0, y: 670.0, width: 274.0, height: 40.0)
        signUpButton.setTitle("Sign Up", for: .normal)
        // need to set text bold
        signUpButton.layer.cornerRadius = signUpButton.frame.height / 2
        signUpButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        signUpButton.setTitleColor(#colorLiteral(red: 0.4078431373, green: 0.007843137255, blue: 0.1490196078, alpha: 1), for: .normal)
        self.view.addSubview(signUpButton)
        

        



        
        
//        let image : UIImage = UIImage(named: "logo.png")!
//        bgImage = UIImageView(image: image)
//        bgImage!.frame = CGRect(x: 0, y: 0, width: 100, height: 200)
//        self.view.addSubview(bgImage)
        
//        let image = UIImage(named: "AppLogo.png")
//        let imageView = UIImageView(image: image)
//        imageView.addSubview(imageView)
//        imageView.frame = CGRect(x: 0,y: 0, width: 100, height: 200)
        
//        viewC.addSubview(circleView)
//        rectangleView.frame = CGRect(x: 136, y: 194, width: 104, height: 104)
//        rectangleView.layer.cornerRadius = 50
        

        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "best-poly-backgrounds.png")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        
        
    }
    @objc func buttonClicked(_ : UIButton){
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
