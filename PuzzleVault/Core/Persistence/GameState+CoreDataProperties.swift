//
//  GameState+CoreDataProperties.swift
//  PuzzleVault
//
//  Created by Valentyn Kotenko on 11/6/25.
//

import Foundation
import CoreData

extension GameState {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<GameState> {
        return NSFetchRequest<GameState>(entityName: "GameState")
    }
    
    @NSManaged public var id: UUID
    @NSManaged public var puzzleType: String
    @NSManaged public var timestamp: Date
    @NSManaged public var data: Data
}

extension GameState: Identifiable {}
