//
//  GameViewController.swift
//  gloopdrop
//
//  Created by Tammy Coron on 1/24/2020.
//  Copyright © 2020 Just Write Code LLC. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Create the view
    if let view = self.view as! SKView? {
      
      // Create the scene
      // let scene = GameScene(size:view.bounds.size)
      let scene = GameScene(size: CGSize(width: 1336, height: 1024))
      
      // Set the scale mode to scale to fill the view window
      scene.scaleMode = .aspectFill
      
      // Set the background color
      scene.backgroundColor =  UIColor(red: 105/255,
                                       green: 157/255,
                                       blue: 181/255,
                                       alpha: 1.0)
      
      // Present the scene
      view.presentScene(scene)
      
      // Set the view options
      view.ignoresSiblingOrder = false
      view.showsPhysics = true
      view.showsFPS = true
      view.showsNodeCount = true
    }
  }
  
  override var shouldAutorotate: Bool {
    return true
  }
  
  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return .landscape
  }
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
}
