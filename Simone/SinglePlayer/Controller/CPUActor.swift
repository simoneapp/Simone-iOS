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
        sequence.append(SimoneColorEnum.all[SimoneColorEnum.all.count.randomInto()])
    }
    
    

    /*
 Then override -setup:, define what kind of messeges actor can accept and provide reactions for them:
 
 - (void)setup {
 [self on:[THLogin class] doFuture:^RXPromise *(THLogin *message) {
 return [self askSession:message.email password:message.password];
 }];
 
 [self on:[THLogout class] _do:^(id o) {
 [self.sessionStorage clear];
 }];
 }
 There 3 types of reactions to message:
 
 void - just do work, return nothing;
 result - return result immediately;
 future - return future object - useful for async tasks, or then message is redirected to another actor.
 */
}
