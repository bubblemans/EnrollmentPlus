//
//  detailCollectionView.swift
//  DeanzaClassRegister
//
//  Created by Alvin Lin on 2018/9/9.
//  Copyright © 2018 Alvin Lin. All rights reserved.
//

import UIKit

class DetailCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    let icon: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        return imageView
    }()
    
    func setUpView() {
        backgroundColor = .blue
        icon.frame = CGRect(x: 20, y: 25, width: 50, height: 50)
        addSubview(icon)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
