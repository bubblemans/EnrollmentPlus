//
//  CalendarTimeView.swift
//  DeanzaClassRegister
//
//  Created by Alvin Lin on 2018/11/21.
//  Copyright © 2018 Alvin Lin. All rights reserved.
//

import UIKit

class CalendarTimeView: UIView {
    let wid = CGFloat(69.0)
    let hei = CGFloat(70)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupLabel()
    }
    
    public func setupLabel() {
        let sevenLabel = makeLabel(y: 0, content: "07:00")
        self.addSubview(sevenLabel)
        
    }
    
    private func makeLabel(y: CGFloat, content: String) -> UILabel {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        label.frame = CGRect(x: 0, y: y, width: wid, height: hei)
        label.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        label.layer.borderWidth = 1
        label.textAlignment = .center
        label.text = content
        return label
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}






