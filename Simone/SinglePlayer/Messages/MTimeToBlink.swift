//
//  MTimeToBlink.swift
//  Simone
//
//  Created by Nicola on 17/09/2017.
//  Copyright © 2017 Simone Games, Inc. All rights reserved.
//

import UIKit

class MTimeToBlink: Message {
    var sequence : [SimoneColorEnum]?
    
    init(sequence: [SimoneColorEnum]) {
        self.sequence = sequence
    }
}
