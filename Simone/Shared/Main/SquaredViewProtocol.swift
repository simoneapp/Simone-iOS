//
//  SquaredViewProtocol.swift
//  Simone
//
//  Created by Nicola on 12/09/2017.
//  Copyright © 2017 Simone Games, Inc. All rights reserved.
//

import Foundation
import UIKit

protocol SquaredViewProtocol {
    var btnFirst : UIButton! { get }
    var btnSecond : UIButton! { get }
    var btnThird : UIButton! { get }
    var btnFourth : UIButton! { get }
    func didTapFirst()
    func didTapSecond()
    func didTapThird()
    func didTapFourth()
}
