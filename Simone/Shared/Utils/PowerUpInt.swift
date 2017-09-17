//
//  PowerUpInt.swift
//  Simone
//
//  Created by Nicola on 17/09/2017.
//  Copyright © 2017 Simone Games, Inc. All rights reserved.
//

import UIKit

extension Int {

    func randomInto() -> Int {
        return Int(arc4random_uniform(UInt32(self)) + 1)
    }
}
