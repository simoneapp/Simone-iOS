//
//  SimoneFabButton.swift
//  Simone
//
//  Created by Nicola on 14/09/2017.
//  Copyright © 2017 Simone Games, Inc. All rights reserved.
//

import UIKit

class SimoneFabButton: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepare(frame)
    }
    
    func prepare(_ rect: CGRect) {
        
        assert(rect.size.height == rect.size.width, "The view is not square, I can't shape a circle")
        
        layer.cornerRadius = rect.size.height / 2.0
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: rect.size.height / 20.0)
        layer.shadowRadius = 10.0
        layer.shadowOpacity = 0.15
        
        
        setTitleColor(.gray, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: rect.size.height * 0.25, weight: .black)
    }
}
