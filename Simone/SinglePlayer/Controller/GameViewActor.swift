//
//  GameViewActor.swift
//  Simone
//
//  Created by Nicola on 17/09/2017.
//  Copyright © 2017 Simone Games, Inc. All rights reserved.
//

import Foundation
import UIKit
import Oscar

protocol GameViewActorProtocol {
    func attachPresenter(_ message: Message)
    func sendBeginMessage(_ message: Message)
    func timeToBlink(_ message: Message)
    func nextColor()
    func handlePlayerTurn(_ message: Message)
    func guessColor(_ message: Message)
    func pause(_ message: Message)
}

class GameViewActor: OSActor, GameViewActorProtocol {

    private var presenter : GameViewPresenterProtocol?
    private var cpuSequence : [SimoneColorEnum] = []
    private var playerSequence : [SimoneColorEnum] = []
    private var cpuIndex = 0
    private var playerIndex = 0
    private var playerTurn = false
    private var paused = false
    
    override func setup() {
        
        on(MAttachPresenter.self) { (result) -> Any? in
            return self.attachPresenter(result as! Message)
        }
        
        on(MStartGameVsCpu.self) { (result) -> Any? in
            return self.sendBeginMessage(result as! Message)
        }
        
        on(MTimeToBlink.self) { (result) -> Any? in
            return self.timeToBlink(result as! Message)
        }
        
        on(MNextColor.self) { (result) -> Any? in
            return self.nextColor()
        }
        
        on(MPlayerTurn.self) { (result) -> Any? in
            return self.handlePlayerTurn(result as! Message)
        }
        
        on(MGuessColor.self) { (result) -> Any? in
            return self.guessColor(result as! Message)
        }
        
        on(MPause.self) { (result) -> Any? in
            return self.pause(result as! Message)
        }
    }
    
    /**
     * Received MAttachPresenter from GameViewControllerPresenter
     * @param message
     */
    func attachPresenter(_ message: Message) {
        guard let message = message as? MAttachPresenter else { return }
        presenter = message.presenter
    }
    
    func sendBeginMessage(_ message: Message) {
        sendToCpuActor(message: message)
    }
    
    /**
     * Time to blink the cpuSequence until it's over
     * @param message
     */
    func timeToBlink(_ message: Message) {
        guard let message = message as? MTimeToBlink else { return }
        cpuIndex = 0
        paused = false
        playerTurn = false
        
        if let sequence = message.sequence {
            cpuSequence = sequence
        }
        
        nextColor()
        
        //currentSender.tell(new TestMessage(), self());
        //getSelf().tell(new NextColorMsg(), currentSender);
    }
    
    /**
     * Next color to blink, if the index is = size --> Player turn
     */
    func nextColor() {
        
        if paused { return }
        
        if cpuIndex >= cpuSequence.count {
            playerTurn = true
            handlePlayerTurn(MPlayerTurn()) //to do with actors here
        } else {
            blink(color: cpuSequence[cpuIndex])
            cpuIndex += 1
        }
    }
    
    /**
     * Player turn, msg to the public handler of GameViewPresenter
     */
    func handlePlayerTurn(_ message: Message) {
        playerIndex = 0
        playerSequence.removeAll()
        presenter?.changeTurn(.player, sequenceIndex: cpuSequence.count - 1)
    }
    
    /**
     * Check of the color guessed by the player
     * @param message
     */
    func guessColor(_ message: Message) {
        
        guard let message = message as? MGuessColor else { return }
        guard playerTurn else { return }
        
        if cpuSequence.count - playerSequence.count > 0 {
            playerSequence.append(message.guessedColor)
            let player = playerSequence[playerIndex]
            let cpu = cpuSequence[cpuIndex]
            
            /*
             Correct -- If sequence is completed --> CPUActor has to compute another color
             else --> player can continue tapping
             */
            if player == cpu {
                
                if cpuSequence.count - playerSequence.count == 0 {
                    
                    presenter?.changeTurn(.cpu, sequenceIndex: playerIndex)
                    sendToCpuActor(message: MGimmeNewColor())
                    playerSequence.removeAll()
                }
                
                playerIndex += 1
                
            } else {
                playerSequence.removeAll()
                playerIndex = 0
                cpuSequence.removeAll()
                cpuIndex = 0
                presenter?.gameLost(score: cpuSequence.count - 1)
            }
        }
    }
    
    func pause(_ message: Message) {
        guard let message = message as? MPause else { return }
        paused = message.isPausing
        
        if !paused {
            sendToCpuActor(message: MNextColor())
        }
    }
    
    private func blink(color : SimoneColorEnum) {
        presenter?.blinkDelayed(turn: .cpu, color: color)
    }
    
    private func sendToCpuActor(message: Message) {
        let system = ActorSystemManager.manager.system
        let actor = system?.actor(of: CPUActor.self, caller: self)
        actor?.tell(message)
    }
}
