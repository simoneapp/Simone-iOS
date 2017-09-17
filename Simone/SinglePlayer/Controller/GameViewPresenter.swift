//
//  GameViewPresenter.swift
//  Simone
//
//  Created by Nicola on 17/09/2017.
//  Copyright © 2017 Simone Games, Inc. All rights reserved.
//

import UIKit

protocol GameViewPresenterProtocol {
    func blinkDelayed(turn: UserType, color: SimoneColorEnum)
    func changeTurn(_ turn: UserType, sequenceIndex: Int)
    func gameLost(score: Int)
}


class GameViewPresenter: NSObject {

}
