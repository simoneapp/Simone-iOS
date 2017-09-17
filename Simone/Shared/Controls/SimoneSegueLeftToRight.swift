//
//  SimoneSegueLeftToRight.swift
//  Simone
//
//  Created by Nicola on 14/09/2017.
//  Copyright © 2017 Simone Games, Inc. All rights reserved.
//

import UIKit

class SimoneSegueLeftToRight: SimoneSegue {
    
    override func getDestinationInitialFrame() -> CGRect {
        let w = UIScreen.main.bounds.size.width
        let h = UIScreen.main.bounds.size.height
        return CGRect(x: -w, y: 0, width: w, height: h)
    }
    
    override func setFramesAfterAnimation() {
        let w = UIScreen.main.bounds.size.width
        source.view.frame = source.view.frame.offsetBy(dx: w, dy: 0)
        destination.view.frame = destination.view.frame.offsetBy(dx: w, dy: 0)
    }
    
}
