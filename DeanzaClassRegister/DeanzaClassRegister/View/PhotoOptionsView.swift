//
//  PhotoOptionsView.swift
//  DeanzaClassRegister
//
//  Created by Alvin Lin on 2018/9/20.
//  Copyright © 2018 Alvin Lin. All rights reserved.
//

import UIKit

class PhotoOptionsView: UIView, UICollectionViewDataSource, UICollectionViewDelegate {
    let cellId = "cellId"
    
    let collectionView: UICollectionView  = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        view.layer.cornerRadius = 10

        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        
        addSubview(collectionView)
        collectionView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        collectionView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = .white
        return cell
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
