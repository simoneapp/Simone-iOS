//
//  CPUActor.swift
//  Simone
//
//  Created by Nicola on 14/09/2017.
//  Copyright © 2017 Simone Games, Inc. All rights reserved.
//

import Foundation
import UIKit
import Oscar

protocol CPUActorProtocol {
    func startGame()
    func generateAndSendColor()
}

class CPUActor: OSActor {
    
    private var sequence: [SimoneColorEnum] = []
    
    override func setup() {
        
        on(MStartGameVsCpu.self) { (result) -> Any? in
            return self.startGame()
        }
        
        on(MGimmeNewColor.self) { (result) -> Any? in
            return self.generateAndSendColor()
        }
    }
    
    func startGame() {
        sequence.removeAll()
        generateAndSendColor()
    }
    
    func generateAndSendColor() {
        guard let viewActor = actorSystem.actor(of: GameViewActor.self, caller: self)
            else { return }
        
        sequence.append(SimoneColorEnum.all[SimoneColorEnum.all.count.randomInto()])
        viewActor.tell(MTimeToBlink(sequence: sequence))
    }
    
}
