//
//  Team.swift
//  AddPlayers
//
//  Created by Varun Mathuria on 11/8/15.
//  Copyright © 2015 VarunMathuria. All rights reserved.
//

import UIKit

class Team {
    
    var name: String
    var players: [Player]
    
    init?(name: String, players: [Player]) {
        self.name = name
        self.players = players
    }
    
}