//
//  Player.swift
//  AddPlayers
//
//  Created by Varun Mathuria on 10/29/15.
//  Copyright © 2015 VarunMathuria. All rights reserved.
//

import UIKit

class Player: NSObject, NSCoding {
    
    // MARK: Properties
    
    struct PropertyKey {
        static let nameKey = "name"
        static let preferredPositionKey = "preferredPositionKey"
        static let currentPositionKey = "currentPositionKey"
    }
    
    var name: String
    var preferredPosition: PositionControl.Position
    var currentPosition: PositionControl.Position
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("players")
    // MARK: Initialization
    
    init?(name: String, preferredPosition: PositionControl.Position, currentPosition: PositionControl.Position=PositionControl.Position.LF) {
        self.name = name
        self.preferredPosition = preferredPosition
        self.currentPosition = PositionControl.Position.LF
        
        super.init()
        
        // Initialization should fail if there is no name
//        if name.isEmpty {
//            return nil
//        }
    }
    
    // MARK: NSCoding
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(self.preferredPosition.rawValue, forKey: PropertyKey.preferredPositionKey)
        aCoder.encodeObject(self.currentPosition.rawValue, forKey: PropertyKey.currentPositionKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let preferredPosition = aDecoder.decodeObjectForKey(PropertyKey.preferredPositionKey) as! Int
        let currentPosition = aDecoder.decodeObjectForKey(PropertyKey.currentPositionKey) as! Int
        self.init(name: name, preferredPosition: PositionControl.Position.allValues[preferredPosition], currentPosition: PositionControl.Position.allValues[currentPosition])
    }
    
    
}
