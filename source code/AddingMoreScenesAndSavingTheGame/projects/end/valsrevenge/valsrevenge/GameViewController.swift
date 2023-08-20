//
//  GameViewController.swift
//  valsrevenge
//
//  Created by Tammy Coron on 7/4/20.
//  Copyright © 2020 Just Write Code LLC. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

protocol GameViewControllerDelegate {
  func didChangeLayout()
}

class GameViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()

    // Create the view
    if let view = self.view as! SKView? {
      
      // Create the scene
      let scene = TitleScene(fileNamed: "TitleScene")
      
      // Set the scale mode to scale to fill the view window
      scene?.scaleMode = .aspectFill
      
      // Present the scene
      view.presentScene(scene)
      
      // Set the view options
      view.ignoresSiblingOrder = false
      view.showsPhysics = false
      view.showsFPS = false
      view.showsNodeCount = false
    }
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    guard
      let skView = self.view as? SKView,
      let gameViewControllerDelegate = skView.scene as?
      GameViewControllerDelegate else { return }
    
    gameViewControllerDelegate.didChangeLayout()
  }
  
  override var shouldAutorotate: Bool {
    return true
  }
  
  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    if UIDevice.current.userInterfaceIdiom == .phone {
      return .allButUpsideDown
    } else {
      return .all
    }
  }
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
}
