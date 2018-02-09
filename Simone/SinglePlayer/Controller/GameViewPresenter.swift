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
    var finalScore: Int { get }
    var playerIsBlinking: Bool { get }
    func prepareGame(message: Message)
    func blinkDelayed(turn: UserType, color: SimoneColorEnum?)
    func gameLost(score: Int)
    func computePlayerTurn(turn: UserType)
    func computeCpuTurn(score: Int, turn: UserType)
    func handleResume()
    func handlePause()
    func endGame()
}


class GameViewPresenter: NSObject, GameViewPresenterProtocol {
    
    private var viewController: SinglePlayerBaseViewController?
    private var currentScore: Int = 0
    private var type: SinglePlayerType = .easy
    private var viewPaused: Bool = false
    private var gameViewActor: OSActorRef?
    private var sender: OSActorRef?
    
    var finalScore: Int = 0
    var playerIsBlinking: Bool = false
    var tapToBegin: Bool = true
    
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
    
    
    //PUBLIC
    func computePlayerTurn(turn: UserType) {
        if !playerIsBlinking {
            viewController?.updateCentralTextView(with: "your\nturn!")
            if type == .hard {
                viewController?.swapButtonPositions()
            }
        }
        
        playerIsBlinking = true
        
        if turn == .cpu {
            //viewController?.blinkDelayed(amount: 0.1, on: nil)
        }
    }
    
    func prepareGame(message: Message) {
        tapToBegin = false
        finalScore = 0
        playerIsBlinking = false
        gameViewActor?.tell(message)
    }
    
    func computeCpuTurn(score: Int, turn: UserType){
        
        currentScore = score + 1
        
        if playerIsBlinking {
            viewController?.updateCentralTextView(with: "\(currentScore)")
            finalScore = currentScore
            //Score Helper: Check achievements
        }
        
        playerIsBlinking = false
        
        if turn == .cpu {
            //viewController?.blinkDelayed(amount: <#T##Double#>, on: <#T##UIButton#>)
        }
    }
    
    func gameLost(score: Int) {
        finalScore = score
        //Send result to Leaderboard
        //Check N games Achievement
        //Analytics log Score
        tapToBegin = true
        viewController?.saveScore()
        viewController?.renderYouLost(with: finalScore)
    }
    
    func blinkDelayed(turn: UserType, color: SimoneColorEnum? = nil) {
        switch turn {
        case .cpu:
            gameViewActor?.tell(MNextColor())
            break
        case .player:
            guard let color = color else { return }
            gameViewActor?.tell(MGuessColor(guessedColor: color))
            break
        }
    }
    
    func handleResume() {
        if !playerIsBlinking && viewPaused {
            viewPaused = false
            gameViewActor?.tell(MPause(isPausing: false))
        }
    }
    
    func handlePause() {
        if !playerIsBlinking {
            viewPaused = true
            gameViewActor?.tell(MPause(isPausing: true))
        }
    }
    
    func endGame() {
        //Send result to Leaderboard
        //Play Simone Music
    }
    
    func blinkDelayed(time: Double) {
        //getHandler().sendMessageDelayed(m, time);
    }
    

}
