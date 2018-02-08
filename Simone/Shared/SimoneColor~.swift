//
//  SimoneColor.swift
//  Simone
//
//  Created by Nicola on 14/09/2017.
//  Copyright © 2017 Simone Games, Inc. All rights reserved.
//

import Foundation
import UIKit

struct SimoneColor {
    var color : UIColor
}

enum SimoneColorEnum {
    case green
    case red
    case yellow
    case blue
    static let all = [green, red, yellow, blue]
}
