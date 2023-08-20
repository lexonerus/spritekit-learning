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
      scene.gameSceneDelegate = self
      
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
      view.showsPhysics = false
      view.showsFPS = false
      view.showsNodeCount = false
      
      // Set up Google AdMob
      setupBannerAdsWith(id: AdMobHelper.bannerAdID)
      setupRewardAdsWith(id: AdMobHelper.rewardAdID)
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

extension GameViewController: GameSceneDelegate {
  func showRewardVideo() {
    if rewardedAd?.isReady == true {
       rewardedAd?.present(fromRootViewController: self, delegate:self)
    }
  }
}
