//
//  GameViewController.swift
//  gloopdrop
//
//  Created by Alexey Krzywicki on 19.08.2023.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if let view = self.view as! SKView? {
            let scene = GameScene(size: CGSize(width: 1336, height: 1024)) // size of the background
            print("scene size = \(scene.size)")
            scene.scaleMode = .aspectFill
            scene.backgroundColor = UIColor.systemGreen
            view.presentScene(scene)
            view.ignoresSiblingOrder = false
            view.showsPhysics = false
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
