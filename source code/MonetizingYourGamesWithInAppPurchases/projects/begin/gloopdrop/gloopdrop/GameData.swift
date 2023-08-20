//
//  GameData.swift
//  gloopdrop
//
//  Created by Tammy Coron on 1/24/2020.
//  Copyright © 2020 Just Write Code LLC. All rights reserved.
//

import Foundation

class GameData: NSObject, Codable {
  
  // MARK: - Properties
  // var propertyName: type = value
  var freeContinues: Int = 1 {
    didSet {
      saveDataWithFileName("gamedata.json")
    }
  }
  
  static let shared: GameData = {
    let instance = GameData()
    instance.setupObservers()
    
    return instance
  }()
  
  // MARK: - Init
  private override init() {}
  
  // MARK: - Notification Handlers
  func setupObservers() {
    
  }
  
  // MARK: - Save & Load Locally Stored Game Data
  func saveDataWithFileName(_ filename: String) {
    let fullPath = getDocumentsDirectory().appendingPathComponent(filename)
    do {
      let data = try PropertyListEncoder().encode(self)
      let dataFile = try NSKeyedArchiver.archivedData(withRootObject: data,
                                                      requiringSecureCoding: true)
      try dataFile.write(to: fullPath)
    } catch {
      // print("Couldn't write Store Data file.")
    }
  }
  
  func loadDataWithFileName(_ filename: String) {
    let fullPath = getDocumentsDirectory().appendingPathComponent(filename)
    do {
      let contents = try Data(contentsOf: fullPath)
      if let data = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(contents) as? Data {
        let gd = try PropertyListDecoder().decode(GameData.self, from: data)
        
        // Restore data (properties)
        // propertyName = gd.propertyName
        freeContinues = gd.freeContinues
        
      }
    } catch {
      // print("Couldn't load Store Data file.")
    }
  }
  
  // Get the user's documents directory
  fileprivate func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
  }
}
