//
//  SimoneSegueBottomToTop.swift
//  Simone
//
//  Created by Nicola Giancecchi on 08.02.18.
//  Copyright © 2018 Simone Games, Inc. All rights reserved.
//

import UIKit

class SimoneSegueBottomToTop: SimoneSegue {
    
    override func getDestinationInitialFrame() -> CGRect {
        let w = UIScreen.main.bounds.size.width
        let h = UIScreen.main.bounds.size.height
        return CGRect(x: 0, y: h, width: w, height: h)
    }
    
    override func setFramesAfterAnimation() {
        let h = UIScreen.main.bounds.size.height
        source.view.frame = source.view.frame.offsetBy(dx: 0, dy: -h)
        destination.view.frame = destination.view.frame.offsetBy(dx: 0, dy: -h)
    }
    
}

