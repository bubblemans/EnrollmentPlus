//
//  ViewController3.swift
//  DeanzaClassRegister
//
//  Created by Karen Jin on 10/17/18.
//  Copyright © 2018 Alvin Lin. All rights reserved.
//

import UIKit

class ViewController3: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.yellow
        
        // label
        let labelInst = UILabel()
        self.view.addSubview(labelInst)
        labelInst.text = "Page 3"
        labelInst.translatesAutoresizingMaskIntoConstraints = false
        labelInst.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50).isActive = true
        labelInst.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
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
