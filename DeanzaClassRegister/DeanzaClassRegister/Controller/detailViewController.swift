//
//  detailViewController.swift
//  DeanzaClassRegister
//
//  Created by Alvin Lin on 2018/8/23.
//  Copyright © 2018 Alvin Lin. All rights reserved.
//

import UIKit

class detailViewController: UIViewController {
    
    var courses: [Data] = []
    var row = 0
    lazy var course = courses[row]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.title = course.course!

        setupDetailView()
    }
    
    func setupDetailView() {
        print(course.course as Any)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
