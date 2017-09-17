//
//  MPause.swift
//  Simone
//
//  Created by Nicola on 17/09/2017.
//  Copyright © 2017 Simone Games, Inc. All rights reserved.
//

import UIKit

class MPause: Message {
    
    var isPausing : Bool
    
    init(isPausing: Bool) {
        self.isPausing = isPausing
    }

}
