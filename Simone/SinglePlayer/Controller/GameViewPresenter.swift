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
    func blinkDelayed(turn: UserType, color: SimoneColorEnum)
    func gameLost(score: Int)
    func computePlayerTurn(source: MessageSource, color: SimoneColorEnum)
    func computeCpuTurn(score: Int, source: MessageSource, color: SimoneColorEnum)
    func handleBlinkDelayed(turn: UserType, color: SimoneColorEnum )
    func didTapColorButton(color: SimoneColorEnum)
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
    func computePlayerTurn(source: MessageSource, color: SimoneColorEnum){
        if !playerIsBlinking {
            viewController?.updateCentralTextView(with: "your\nturn!")
            if type == .hard {
                viewController?.swapButtonPositions()
            }
        }
        
        playerIsBlinking = true
        
        if source == .presenter {
            viewController?.blinkDelayed(color: color)
        }
    }
    
    func prepareGame(message: Message) {
        tapToBegin = false
        finalScore = 0
        playerIsBlinking = false
        gameViewActor?.tell(message)
    }
    
    func computeCpuTurn(score: Int, source: MessageSource, color: SimoneColorEnum){
        
        currentScore = score + 1
        
        if playerIsBlinking {
            viewController?.updateCentralTextView(with: "\(currentScore)")
            finalScore = currentScore
            //Score Helper: Check achievements
        }
        
        playerIsBlinking = false
        
        if source == .presenter {
            viewController?.blinkDelayed(color: color)
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
    
    func blinkDelayed(turn: UserType, color: SimoneColorEnum) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            switch turn {
            case .cpu: self?.computeCpuTurn(score: 0, source: .presenter, color: color); break
            case .player: self?.computePlayerTurn(source: .presenter, color: color); break
            }
        }
    }
    
    func handleBlinkDelayed(turn: UserType, color: SimoneColorEnum ) {

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.viewController?.resetButton(for: color)
            switch turn {
            case .cpu: self?.gameViewActor?.tell(MNextColor()); break
            case .player: self?.gameViewActor?.tell(MGuessColor(guessedColor: color))
            }
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
    
    func didTapColorButton(color: SimoneColorEnum) {
        if playerIsBlinking && !tapToBegin {
            self.computePlayerTurn(source: .presenter, color: color)
        }
    }

}
