//
//  SimoneSegue.swift
//  Simone
//
//  Created by Nicola on 14/09/2017.
//  Copyright © 2017 Simone Games, Inc. All rights reserved.
//

import UIKit

class SimoneSegue: UIStoryboardSegue, SimoneConcreteSegueProtocol {
    
    override func perform() {
        destination.view.frame = getDestinationInitialFrame()
        
        let window = UIApplication.shared.keyWindow
        window?.insertSubview(destination.view, aboveSubview: source.view)
        UIView.animate(withDuration: 0.25, animations: {
            self.setFramesAfterAnimation()
        }) { (completed) in
            if let result = self.identifier?.starts(with: "unwind"), result {
                self.source.dismiss(animated: false, completion: nil)
            } else {
                self.source.present(self.destination, animated: false, completion: nil)
            }
        }
    }
    
    func getDestinationInitialFrame() -> CGRect {
        assertionFailure("Concrete method should be implemented by subclasses.")
        return .zero
    }
    
    func setFramesAfterAnimation() {
        assertionFailure("Concrete method should be implemented by subclasses.")
    }
    
}

