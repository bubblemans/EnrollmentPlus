//
//  MenuButton.swift
//  DeanzaClassRegister
//
//  Created by Alvin Lin on 2018/9/18.
//  Copyright © 2018 Alvin Lin. All rights reserved.
//

import UIKit

class MenuButton: UIButton {
    var baseController: TableViewController?
    var selectedIndexPath: IndexPath?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, image: UIImage) {
        self.init(frame: frame)
        self.frame = frame
        self.widthAnchor.constraint(equalToConstant: frame.width).isActive = true
        self.heightAnchor.constraint(equalToConstant: frame.height).isActive = true
        
        self.tintColor = .white
        self.setImage(image, for: UIControl.State())
        self.addTarget(self, action: #selector(handleMenu), for: .touchUpInside)
        self.contentMode = .scaleAspectFit
    }
    
    let menuLanucher = MenuLauncher()
    
    @objc func handleMenu() {
        menuLanucher.showMenu()
        menuLanucher.baseController = baseController
        
        if selectedIndexPath == nil {
            let homeIndex = IndexPath(item: 0, section: 0)
            menuLanucher.collectionView.selectItem(at: homeIndex, animated: false, scrollPosition: .centeredVertically)
        } else {
            menuLanucher.collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .centeredVertically)
        }
    }
}


