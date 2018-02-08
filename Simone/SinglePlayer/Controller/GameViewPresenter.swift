//
//  GameViewPresenter.swift
//  Simone
//
//  Created by Nicola on 17/09/2017.
//  Copyright © 2017 Simone Games, Inc. All rights reserved.
//

import UIKit
import Oscar

protocol GameViewPresenterProtocol {
    var tapToBegin: Bool { get }
    var finalScore: Bool { get }
    func blinkDelayed(turn: UserType, color: SimoneColorEnum)
    func changeTurn(_ turn: UserType, sequenceIndex: Int)
    func gameLost(score: Int)
}


class GameViewPresenter: NSObject, GameViewPresenterProtocol {
    
    private var viewController: SinglePlayerBaseViewController?
    private var currentScore: Int = 0
    var finalScore: Int = 0
    private var type: SinglePlayerType = .easy
    private var playerIsBlinking: Bool = false
    var tapToBegin: Bool = true
    private var viewPaused: Bool = false
    private var gameViewActor: OSActorRef?
    private var sender: OSActorRef?
    
    init(viewController: SinglePlayerBaseViewController,
         type: SinglePlayerType,
         system: OSActorSystem? = nil,
         sender: OSActorRef? = nil) {
        super.init()
        self.viewController = viewController
        self.type = type
        self.sender = sender
        self.gameViewActor = ActorSystemManager.manager.system?.actor(of: GameViewActor.self, caller: self)
        self.gameViewActor?.tell(MAttachPresenter(presenter: self))
    }
    
    func blinkDelayed(turn: UserType, color: SimoneColorEnum) {
        
    }
    
    func changeTurn(_ turn: UserType, sequenceIndex: Int) {
        
        if !playerIsBlinking {
            //viewController.updateSimoneTextView
        }
    }
    
    func gameLost(score: Int) {
        
    }
    

}
