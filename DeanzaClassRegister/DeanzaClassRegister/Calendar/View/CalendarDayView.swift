//
//  CalendarDayView.swift
//  DeanzaClassRegister
//
//  Created by Alvin Lin on 2018/11/21.
//  Copyright © 2018 Alvin Lin. All rights reserved.
//

import UIKit

class CalendarDayView: UIView {
    var wid = CGFloat(414.0 / 6)
    let hei = CGFloat(50)
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
//        setupDayLabel()
    }
    
    public func setupDayLabel() {
        let monLabel = makeLabel(x: wid, content: "MON")
        self.addSubview(monLabel)
        
        let tuesLabel = makeLabel(x: 2 * wid, content: "TUE")
        self.addSubview(tuesLabel)

        let wedLabel = makeLabel(x: 3 * wid, content: "WED")
        self.addSubview(wedLabel)

        let thurLabel = makeLabel(x: 4 * wid, content: "THU")
        self.addSubview(thurLabel)

        let friLabel = makeLabel(x: 5 * wid, content: "FRI")
        self.addSubview(friLabel)
        
        
        
        
    }
    
    private func makeLabel(x: CGFloat, content: String) -> UILabel {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        label.frame = CGRect(x: x, y: 0, width: wid, height: hei)
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






