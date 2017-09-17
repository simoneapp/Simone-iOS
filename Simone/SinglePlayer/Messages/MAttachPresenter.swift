//
//  MAttachView.swift
//  Simone
//
//  Created by Nicola on 17/09/2017.
//  Copyright © 2017 Simone Games, Inc. All rights reserved.
//

import UIKit

class MAttachPresenter: Message {
    var presenter : GameViewPresenterProtocol?
    
    init(presenter : GameViewPresenterProtocol) {
        self.presenter = presenter
    }
}
