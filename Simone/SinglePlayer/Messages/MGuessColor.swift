//
//  MGuessColor.swift
//  Simone
//
//  Created by Nicola on 17/09/2017.
//  Copyright © 2017 Simone Games, Inc. All rights reserved.
//

import UIKit

class MGuessColor: Message {
    
    var guessedColor : SimoneColorEnum

    init(guessedColor : SimoneColorEnum) {
        self.guessedColor = guessedColor
    }
}
