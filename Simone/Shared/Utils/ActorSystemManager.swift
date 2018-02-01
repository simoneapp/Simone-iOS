//
//  ActorSystemManager.swift
//  Simone
//
//  Created by Nicola on 22/09/2017.
//  Copyright © 2017 Simone Games, Inc. All rights reserved.
//

import UIKit
import Oscar

class ActorSystemManager: NSObject {

    var system : OSMainActorSystem?
    
    static var manager = ActorSystemManager()
    
    override init() {
        //self.createActors()
    }
    
    func createActors() {
        system = OSMainActorSystem(configs: nil) { (builder) in
            builder?.addActor({ (system) -> OSActor? in
                return CPUActor.actor(with: system)
            })
            builder?.addActor({ (system) -> OSActor? in
                return GameViewActor.actor(with: system)
            })
        }
    }
}
