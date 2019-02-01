//
//  MenuCollectionViewCell.swift
//  DeanzaClassRegister
//
//  Created by Alvin Lin on 2018/9/14.
//  Copyright © 2018 Alvin Lin. All rights reserved.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    let label: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        return label
    }()
    
    let imageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    func setupView() {
        backgroundColor = .white
        
        self.addSubview(label)
        label.frame = CGRect(x: 50, y: 0, width: self.frame.width - 50, height: self.frame.height)
        
        self.addSubview(imageView)
        imageView.frame = CGRect(x: 5, y: 5, width: 30, height: 30)
        imageView.tintColor = .black
        imageView.backgroundColor = .white
    }
    
    override var isSelected: Bool {
        didSet {
            imageView.backgroundColor = isSelected ? #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1) : .white
            label.backgroundColor = isSelected ? #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1) : .white
            self.backgroundColor = isSelected ? #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1) : .white
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}









