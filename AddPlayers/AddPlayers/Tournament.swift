//
//  Tournament.swift
//  AddPlayers
//
//  Created by Varun Mathuria on 11/8/15.
//  Copyright © 2015 VarunMathuria. All rights reserved.
//

import UIKit

class Tournament {

    var name: String
    var teams: [Team]
    var leftovers: [Player]
    var players: [Player]
    
    init?(name: String, var players: [Player]) {
        self.name = name
        self.teams = [Team]()
        self.leftovers = [Player]()
        self.players = players
        self.players.shuffle()
        var num_teams = Int(floor(Double(players.count) / Double(6)))
        for var i = 0; i < num_teams; ++i {
            var curr_team = fillFavePositions(i + 1)
            teams.append(curr_team)
        }
        for team in teams {
            fillRestPositions(team)
        }
        leftovers = players
    }

    func fillFavePositions(team_num: Int) -> Team {
        var player_list = [Player]()
        for pos in PositionControl.Position.allValues {
            for p in self.players {
                let p1 = pos.rawValue
                let p2 = p.preferredPosition.rawValue
                if p1 == p2 {
                    p.currentPosition = pos
                    player_list.append(p)
                    let foundIndex = players.indexOf(p)
                    self.players.removeAtIndex(foundIndex!)
                    break
                }
            }
        }
        var returned = Team(name: String(team_num), players: player_list)
        return returned!
    }
    
    func fillRestPositions(team: Team) {
        var eP = emptyPositions(team)
        for str in eP {
            var curr_player = self.players[0]
            curr_player.currentPosition = PositionControl.getEnumFromString[str]!
            team.players.append(curr_player)
            self.players.removeAtIndex(0)
        }
    }
    
    func emptyPositions(team: Team) -> [String] {
        var returned = [String]()
        for (_, value) in PositionControl.fullPositionNames {
            returned.append(value)
        }
        var toRemove = [String]()
        for pos in PositionControl.Position.allValues {
            for p in team.players {
                let p1 = pos.rawValue
                let p2 = p.currentPosition.rawValue
                if p1 == p2 {
                    toRemove.append(PositionControl.fullPositionNames[pos]!)
                    break
                }
            }
        }
        for tR in toRemove {
            let foundIndex = returned.indexOf(tR)
            returned.removeAtIndex(foundIndex!)
        }
        return returned
    }
    
    
}

extension Array {
    mutating func shuffle() {
        if count < 2 { return }
        for i in 0..<(count - 1) {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            swap(&self[i], &self[j])
        }
    }
}