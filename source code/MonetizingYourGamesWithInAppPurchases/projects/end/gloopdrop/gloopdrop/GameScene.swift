//
//  GameScene.swift
//  gloopdrop
//
//  Created by Tammy Coron on 1/24/2020.
//  Copyright © 2020 Just Write Code LLC. All rights reserved.
//

import AVFoundation
import SpriteKit
import GameplayKit

protocol GameSceneDelegate: AnyObject {
  func showRewardVideo()
}

class GameScene: SKScene {
  
  weak var gameSceneDelegate: GameSceneDelegate?
  
  let player = Player()
  let playerSpeed: CGFloat = 1.5
  
  // Player movement
  var movingPlayer = false
  var lastPosition: CGPoint?
  
  var level: Int = 1 {
    didSet {
      levelLabel.text = "Level: \(level)"
    }
  }

  var score: Int = 0 {
    didSet {
      scoreLabel.text = "Score: \(score)"
    }
  }
  
  var numberOfDrops: Int = 10
  
  var dropsExpected = 10
  var dropsCollected = 0
  
  var dropSpeed: CGFloat = 1.0
  var minDropSpeed: CGFloat = 0.12 // (fastest drop)
  var maxDropSpeed: CGFloat = 1.0 // (slowest drop)
  var prevDropLocation: CGFloat = 0.0
  
  // Labels
  var scoreLabel: SKLabelNode = SKLabelNode()
  var levelLabel: SKLabelNode = SKLabelNode()
  
  // Start game button
  let startGameButton = SKSpriteNode(imageNamed: "start")
  
  // Audio nodes
  let musicAudioNode = SKAudioNode(fileNamed: "music.mp3")
  let bubblesAudioNode = SKAudioNode(fileNamed: "bubbles.mp3")
  
  // Game states
  var gameInProgress = false
  // var playingLevel = false
  
  // Continue Game
  let watchAdButton = SKSpriteNode(imageNamed: "watchAd")
  let continueGameButton = SKSpriteNode(imageNamed: "continueRemaining-0")
  let maxNumberOfContinues = 6
  var numberOfFreeContinues: Int {
    get {
      return GameData.shared.freeContinues
    }
    set(newValue) {
      GameData.shared.freeContinues = newValue
      updateContinueButton()
    }
  }
  var numberOfPaidContinues: Int {
    get {
      var qty: Int = 0
      for product in GameData.shared.products {
        if product.id.contains("continue") {
          qty += product.quantity
        }
      }
      return qty
    }
    set(newValue) {
      let product = GameData.shared.products.filter(
      {$0.id.contains("continue")}).first
      product?.quantity = newValue
      updateContinueButton()
    }
  }
  var numberOfContinues: Int {
    get {
      return numberOfFreeContinues + numberOfPaidContinues
    }
  }

  var isContinue: Bool = false
  
  // Reference Scene
  let shopButton = SKSpriteNode(imageNamed: "shop")
  var shopScene: ShopScene!
  var shopIsOpen = false
  
  override func didMove(to view: SKView) {
    
    // Set up notification observers
    setupAdMobObservers()
    
    // Decrease the audio engine's volume
    audioEngine.mainMixerNode.outputVolume = 0.0
    
    // Set up the background music audio node
    musicAudioNode.autoplayLooped = true
    musicAudioNode.isPositional = false

    // Add the audio node to the scene
    addChild(musicAudioNode)
    
    // Use an action to adjust the audio node's volume to 0
    musicAudioNode.run(SKAction.changeVolume(to: 0.0, duration: 0.0))
    
    // Run a delayed action on the scene that fades-in the music
    run(SKAction.wait(forDuration: 1.0), completion: { [unowned self] in
      self.audioEngine.mainMixerNode.outputVolume = 1.0
      self.musicAudioNode.run(SKAction.changeVolume(to: 0.75, duration: 2.0))
    })
    
    // Run a delayed action to add bubble audio to the scene
    run(SKAction.wait(forDuration: 1.5), completion: { [unowned self] in
      self.bubblesAudioNode.autoplayLooped = true
      self.addChild(self.bubblesAudioNode)
    })
    
    // Set up the physics world contact delegate
    physicsWorld.contactDelegate = self
    
    // Set up background
    let background = SKSpriteNode(imageNamed: "background_1")
    background.name = "background"
    background.anchorPoint = CGPoint(x: 0, y: 0)
    background.zPosition = Layer.background.rawValue
    background.position = CGPoint(x: 0, y: 0)
    addChild(background)
    
    // Set up foreground
    let foreground = SKSpriteNode(imageNamed: "foreground_1")
    foreground.name = "foreground"
    foreground.anchorPoint = CGPoint(x: 0, y: 0)
    foreground.zPosition = Layer.foreground.rawValue
    foreground.position = CGPoint(x: 0, y: 0)
    
    // Add physics body
    foreground.physicsBody = SKPhysicsBody(edgeLoopFrom: foreground.frame)
    foreground.physicsBody?.affectedByGravity = false
    
    // Set up physics categories for contacts
    foreground.physicsBody?.categoryBitMask = PhysicsCategory.foreground
    foreground.physicsBody?.contactTestBitMask = PhysicsCategory.collectible
    foreground.physicsBody?.collisionBitMask = PhysicsCategory.none
    
    addChild(foreground)
    
    // Set up the banner
    let banner = SKSpriteNode(imageNamed: "banner")
    banner.zPosition = Layer.background.rawValue + 1
    banner.position = CGPoint(x: frame.midX, y: viewTop() - 20)
    banner.anchorPoint = CGPoint(x: 0.5, y: 1.0)
    addChild(banner)
    
    // Set up User Interface
    setupLabels()
    setupStartButton()
    setupContinues()
    setupShop()
    
    // Set up player
    player.position = CGPoint(x: size.width/2, y: foreground.frame.maxY)
    player.setupConstraints(floor: foreground.frame.maxY)
    addChild(player)
    // player.walk()
    
    // Set up game
    // spawnMultipleGloops()
    
    // Show message
    showMessage("Tap Start to Play the Game")
    
    // Set up the gloop flow
    setupGloopFlow()
    
    // Challenge: Set up star particles
    if let stars = SKEmitterNode(fileNamed: "Stars.sks") {
      stars.name = "stars"
      stars.position = CGPoint(x: frame.midX, y: frame.midY)
      addChild(stars)
    }
    
    // Challenge: Create an action to run after a short random delay
    let wait = SKAction.wait(forDuration: 30, withRange: 60)
    let codeBlock = SKAction.run({self.sendRobot()})
    run(SKAction.sequence([wait, codeBlock]))
  }
  
  func setupLabels() {
    /* SCORE LABEL */
    scoreLabel.name = "score"
    scoreLabel.fontName = "Nosifer"
    scoreLabel.fontColor = .yellow
    scoreLabel.fontSize = 35.0
    scoreLabel.horizontalAlignmentMode = .right
    scoreLabel.verticalAlignmentMode = .center
    scoreLabel.zPosition = Layer.ui.rawValue
    scoreLabel.position = CGPoint(x: frame.maxX - 50, y: viewTop() - 100)

    // Set the text and add the label node to scene
    scoreLabel.text = "Score: 0"
    addChild(scoreLabel)
    
    /* LEVEL LABEL */
    levelLabel.name = "level"
    levelLabel.fontName = "Nosifer"
    levelLabel.fontColor = .yellow
    levelLabel.fontSize = 35.0
    levelLabel.horizontalAlignmentMode = .left
    levelLabel.verticalAlignmentMode = .center
    levelLabel.zPosition = Layer.ui.rawValue
    levelLabel.position = CGPoint(x: frame.minX + 50, y: viewTop() - 100)

    // Set the text and add the label node to scene
    levelLabel.text = "Level: \(level)"
    addChild(levelLabel)
  }
  
  func setupStartButton() {
    startGameButton.name = "start"
    startGameButton.setScale(0.55)
    startGameButton.zPosition = Layer.ui.rawValue
    startGameButton.position = CGPoint(x: frame.midX, y: frame.midY)
    addChild(startGameButton)
    
    // Add animation
    let scaleUp = SKAction.scale(to: 0.55, duration: 0.65)
    let scaleDown = SKAction.scale(to: 0.50, duration: 0.65)
    let playBounce = SKAction.sequence([scaleDown, scaleUp])
    let bounceRepeat = SKAction.repeatForever(playBounce)
    startGameButton.run(bounceRepeat)
  }

  func showStartButton() {
    // startGameButton.run(SKAction.fadeIn(withDuration: 0.25))
    // if AdMobHelper.rewardAdReady == true {
      // watchAdButton.run(SKAction.fadeIn(withDuration: 0.25))
    // }
    
    // Tip: Save resources and use a single, shared action
    let hideAction = SKAction.fadeIn(withDuration: 0.25)
    startGameButton.run(hideAction)
    if AdMobHelper.rewardAdReady == true {
      watchAdButton.run(hideAction)
    }
  }

  func hideStartButton() {
    // startGameButton.run(SKAction.fadeOut(withDuration: 0.25))
    // if AdMobHelper.rewardAdReady == true {
      // watchAdButton.run(SKAction.fadeOut(withDuration: 0.25))
    // }
    
    // Tip: Save resources and use a single, shared action
    let hideAction = SKAction.fadeOut(withDuration: 0.25)
    startGameButton.run(hideAction)
    if AdMobHelper.rewardAdReady == true {
      watchAdButton.run(hideAction)
    }
  }
  
  func showMessage(_ message: String) {
    // Set up message label
    let messageLabel = SKLabelNode()
    messageLabel.name = "message"
    messageLabel.position = CGPoint(x: frame.midX,
                                    y: frame.midY + startGameButton.size.height/2)
    messageLabel.zPosition = Layer.ui.rawValue
    
    messageLabel.numberOfLines = 2
    
    // Set up attributed text
    let paragraph = NSMutableParagraphStyle()
    paragraph.alignment = .center
    
    let attributes: [NSAttributedString.Key: Any] = [
      .foregroundColor: SKColor(red: 251.0/255.0, green: 155.0/255.0,
                                blue: 24.0/255.0, alpha: 1.0),
      .backgroundColor: UIColor.clear,
      .font: UIFont(name: "Nosifer", size: 45.0)!,
      .paragraphStyle: paragraph
    ]
    
    messageLabel.attributedText = NSAttributedString(string: message,
                                                     attributes: attributes)
    
    // Run a fade action and add the label to the scene
    messageLabel.run(SKAction.fadeIn(withDuration: 0.25))
    addChild(messageLabel)
  }
  
  func hideMessage() {
    // Remove message label if it exists
    if let messageLabel = childNode(withName: "//message") as? SKLabelNode {
      messageLabel.run(SKAction.sequence([SKAction.fadeOut(withDuration: 0.25),
                                          SKAction.removeFromParent()]))
    }
  }
  
  // MARK: - Challenge
    
  func sendRobot() {
      
    // Set up robot sprite node
    let robot = SKSpriteNode(imageNamed: "robot")
    robot.zPosition = Layer.foreground.rawValue
    robot.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    robot.position = CGPoint(x: frame.maxX + robot.size.width,
                             y: frame.midY + robot.size.height)
    addChild(robot)
    
    // Set up audio node and make it a child of the robot sprite node
    let audioNode = SKAudioNode(fileNamed: "robot.wav")
    audioNode.autoplayLooped = true
    audioNode.run(SKAction.changeVolume(to: 1.0, duration: 0.0))
    robot.addChild(audioNode)
      
    // Create and run a sequence of actions that moves the robot up and down
    let moveUp = SKAction.moveBy(x: 0, y: 15, duration: 0.25)
    let moveDown = SKAction.moveBy(x: 0, y: -15, duration: 0.25)
    let wobbleGroup = SKAction.sequence([moveDown, moveUp])
    let wobbleAction = SKAction.repeatForever(wobbleGroup)
    robot.run(wobbleAction)  // you can not run a completion handler on
                             // on an action that runs forever, so you need
                             // to run this action on its own.
      
    // Create an action that moves the robot left
    let moveLeft = SKAction.moveTo(x: frame.minX - robot.size.width,
                            duration: 6.50)
      
    // Create an action to remove the robot sprite node
    let removeFromParent = SKAction.removeFromParent()
    
    // Combine the actions into a sequence
    let moveSequence = SKAction.sequence([moveLeft, removeFromParent])

    // Periodically run this method using a timed range
    robot.run(moveSequence, completion: {
      let wait = SKAction.wait(forDuration: 30, withRange: 60)
      let codeBlock = SKAction.run({self.sendRobot()})
      self.run(SKAction.sequence([wait, codeBlock]))
    })
  }
  
  // MARK: - Gloop Flow & Particle Effects

  func setupGloopFlow() {

    // Set up flowing gloop
    let gloopFlow = SKNode()
    gloopFlow.name = "gloopFlow"
    gloopFlow.zPosition = Layer.foreground.rawValue
    gloopFlow.position = CGPoint(x: 0.0, y: -60)

    // Use extension for endless scrolling
    gloopFlow.setupScrollingView(imageNamed: "flow_1",
                                 layer: Layer.foreground,
                                 emitterNamed: "GloopFlow.sks",
                                 blocks: 3, speed: 30.0)

    // Add flow to scene
    addChild(gloopFlow)
  }
  
  // MARK: - GAME FUNCTIONS
  
  /* ############################################################ */
  /*                 GAME FUNCTIONS STARTS HERE                   */
  /* ############################################################ */
  
  func spawnMultipleGloops() {
    
    // Hide message
    hideMessage()
    
    // Hide start button
    hideStartButton()
    
    // Start player walk animation
    player.mumble()
    player.walk()
    
    // Reset the level and score
    if gameInProgress == false && isContinue == false {
      score = 0
      level = 1
    } else {
      isContinue = false
    }
    
    // Set number of drops based on the level
    switch level {
    case 1, 2, 3, 4, 5:
      numberOfDrops = level * 10
    case 6:
      numberOfDrops = 75
    case 7:
      numberOfDrops = 100
    case 8:
      numberOfDrops = 150
    default:
      numberOfDrops = 150
    }
    
    // Reset and update the collected and expected drop count
    dropsCollected = 0
    dropsExpected = numberOfDrops
    
    // Set up drop speed
    dropSpeed = 1 / (CGFloat(level) + (CGFloat(level) / CGFloat(numberOfDrops)))
    if dropSpeed < minDropSpeed {
      dropSpeed = minDropSpeed
    } else if dropSpeed > maxDropSpeed {
      dropSpeed = maxDropSpeed
    }
    
    // Set up repeating action
    let wait = SKAction.wait(forDuration: TimeInterval(dropSpeed))
    let spawn = SKAction.run { [unowned self] in self.spawnGloop() }
    let sequence = SKAction.sequence([wait, spawn])
    let repeatAction = SKAction.repeat(sequence, count: numberOfDrops)
    
    // Run action
    run(repeatAction, withKey: "gloop")
    
    // Update game states
    gameInProgress = true
    // playingLevel = true
  }
  
  func spawnGloop() {
    let collectible = Collectible(collectibleType: CollectibleType.gloop)
    
    // set random position
    let margin = collectible.size.width * 2
    let dropRange = SKRange(lowerLimit: frame.minX + margin, upperLimit: frame.maxX - margin)
    var randomX = CGFloat.random(in: dropRange.lowerLimit...dropRange.upperLimit)
    
    /* START ENHANCED DROP MOVEMENT
     this helps to create a "snake-like" pattern */

    // Set a range
    let randomModifier = SKRange(lowerLimit: 50 + CGFloat(level),
                                 upperLimit: 60 * CGFloat(level))
    var modifier = CGFloat.random(in:
                      randomModifier.lowerLimit...randomModifier.upperLimit)
    if modifier > 400 { modifier = 400 }

    // Set the previous drop location
    if prevDropLocation == 0.0 {
      prevDropLocation = randomX
    }

    // Clamp its x-position
    if prevDropLocation < randomX {
      randomX = prevDropLocation + modifier
    } else {
      randomX = prevDropLocation - modifier
    }

    // Make sure the collectible stays within the frame
    if randomX <= (frame.minX + margin) {
      randomX = frame.minX + margin
    } else if randomX >= (frame.maxX - margin) {
      randomX = frame.maxX - margin
    }

    // Store the location
    prevDropLocation = randomX

    /* END ENHANCED DROP MOVEMENT */
    
    // Add the number tag to the collectible drop
    let xLabel = SKLabelNode()
    xLabel.name = "dropNumber"
    xLabel.fontName = "AvenirNext-DemiBold"
    xLabel.fontColor = UIColor.yellow
    xLabel.fontSize = 22.0
    xLabel.text = "\(numberOfDrops)"
    xLabel.position = CGPoint(x: 0, y: 2)
    collectible.addChild(xLabel)
    numberOfDrops -= 1 // decrease drop count by 1
    
    collectible.position = CGPoint(x: randomX, y: player.position.y * 2.5)
    addChild(collectible)
    
    collectible.drop(dropSpeed: TimeInterval(1.0), floorLevel: player.frame.minY)
  }
  
  func checkForRemainingDrops() {
    // if playingLevel == true {
      if dropsCollected == dropsExpected {
        // playingLevel = false
        nextLevel()
      }
    // }
  }

  // Player PASSED level
  func nextLevel() {
    // Show message
    showMessage("Get Ready!")
    
    let wait = SKAction.wait(forDuration: 2.25)
    run(wait, completion:{[unowned self] in self.level += 1
                           self.spawnMultipleGloops()})
  }
  
  // Player FAILED level
  func gameOver() {
    // Show message
    showMessage("Game Over\nStart a New Game or Continue")
    
    // Update game states
    gameInProgress = false
    
    // Start player die animation
    player.die()
    
    // Remove repeatable action on main scene
    removeAction(forKey: "gloop")
    
    // Loop through child nodes and stop actions on collectibles
    enumerateChildNodes(withName: "//co_*") {
      (node, stop) in
      
      // Stop and remove drops
      node.removeAction(forKey: "drop") // remove action
      node.physicsBody = nil // remove body so no collisions occur
    }
    
    // Reset game
    resetPlayerPosition()
    popRemainingDrops()
    
    // Show start button
    showStartButton()
  }
  
  func resetPlayerPosition() {
    let resetPoint = CGPoint(x: frame.midX, y: player.position.y)
    let distance = hypot(resetPoint.x-player.position.x, 0)
    let calculatedSpeed = TimeInterval(distance / (playerSpeed * 2)) / 255

    if player.position.x > frame.midX {
      player.moveToPosition(pos: resetPoint, direction: "L", speed: calculatedSpeed)
    } else {
      player.moveToPosition(pos: resetPoint, direction: "R", speed: calculatedSpeed)
    }
  }
  
  func popRemainingDrops() {
    var i = 0
    enumerateChildNodes(withName: "//co_*") {
      (node, stop) in
      
      // Pop remaining drops in sequence
      let initialWait = SKAction.wait(forDuration: 1.0)
      let wait = SKAction.wait(forDuration: TimeInterval(0.15 * CGFloat(i)))
      
      let removeFromParent = SKAction.removeFromParent()
      let actionSequence = SKAction.sequence([initialWait, wait, removeFromParent])
      
      node.run(actionSequence)
      
      i += 1
    }
  }
  
  /*
  override func update(_ currentTime: TimeInterval) {
    print("""
             \(currentTime): dropsCollected: \(dropsCollected)
             | dropsExpected: \(dropsExpected)
          """)
    checkForRemainingDrops()
  }
  */
  
  // MARK: - TOUCH HANDLING
  
  /* ############################################################ */
  /*                 TOUCH HANDLERS STARTS HERE                   */
  /* ############################################################ */
  
  func touchDown(atPoint pos: CGPoint) {
    let touchedNodes = nodes(at: pos)
    for touchedNode in touchedNodes {
      // print("touchedNode: \(String(describing: touchedNode.name))")
      if shopIsOpen == true {
        if touchedNode.name == "buy" {
          shopScene.purchaseProduct(node: touchedNode)
          return
        } else if touchedNode.name == "shop.restore" {
          shopScene.restorePurchases()
          return
        } else if touchedNode.name == "shop.exit" {
          shopScene.endInteraction()
          shopIsOpen = false
          return
        }
      } else if shopIsOpen == false {
        if touchedNode.name == "shop" && gameInProgress == false {
          shopScene.beginInteraction()
          shopIsOpen = true
          return
        } else if touchedNode.name == "player" && gameInProgress == true {
          movingPlayer = true
        } else if touchedNode == watchAdButton && gameInProgress == false {
          gameSceneDelegate?.showRewardVideo()
          return
        } else if touchedNode == continueGameButton && gameInProgress == false {
          useContinue()
          return
        } else if touchedNode == startGameButton && gameInProgress == false {
          spawnMultipleGloops()
          return
        }
      }
    }
  }
  
  func touchMoved(toPoint pos: CGPoint) {
    if movingPlayer == true {
      // Clamp position
      let newPos = CGPoint(x: pos.x, y: player.position.y)
      player.position = newPos
      
      // Check last position; if empty set it
      let recordedPosition = lastPosition ?? player.position
      if recordedPosition.x > newPos.x {
        player.xScale = -abs(xScale)
      } else {
        player.xScale = abs(xScale)
      }
      
      // Save last known position
      lastPosition = newPos
    }
  }
  
  func touchUp(atPoint pos: CGPoint) {
    movingPlayer = false
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    for t in touches { self.touchDown(atPoint: t.location(in: self)) }
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    for t in touches { self.touchUp(atPoint: t.location(in: self)) }
  }
  
  override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    for t in touches { self.touchUp(atPoint: t.location(in: self)) }
  }
}

// MARK: - COLLISION DETECTION

/* ############################################################ */
/*         COLLISION DETECTION METHODS START HERE               */
/* ############################################################ */

extension GameScene: SKPhysicsContactDelegate {
  func didBegin(_ contact: SKPhysicsContact) {
    // Check collision bodies
    let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
    
    // Did the [PLAYER] collide with the [COLLECTIBLE]?
    if collision == PhysicsCategory.player | PhysicsCategory.collectible {
      // print("player hit collectible")
      
      // Find out which body is attached to the collectible node
      let body = contact.bodyA.categoryBitMask == PhysicsCategory.collectible ?
        contact.bodyA.node :
        contact.bodyB.node

      // Verify the object is a collectible
      if let sprite = body as? Collectible {
        sprite.collected()
        dropsCollected += 1
        score += level
        checkForRemainingDrops()
        
        // Add the 'chomp' text at the player's position
        let chomp = SKLabelNode(fontNamed: "Nosifer")
        chomp.name = "chomp"
        chomp.alpha = 0.0
        chomp.fontSize = 22.0
        chomp.text = "gloop"
        chomp.horizontalAlignmentMode = .center
        chomp.verticalAlignmentMode = .bottom
        chomp.position = CGPoint(x: player.position.x, y: player.frame.maxY + 25)
        chomp.zRotation = CGFloat.random(in: -0.15...0.15)
        addChild(chomp)
        
        // Add actions to fade in, rise up, and fade out
        let fadeIn = SKAction.fadeAlpha(to: 1.0, duration: 0.05)
        let fadeOut = SKAction.fadeAlpha(to: 0.0, duration: 0.45)
        let moveUp = SKAction.moveBy(x: 0.0, y: 45, duration: 0.45)
        let groupAction = SKAction.group([fadeOut, moveUp])
        let removeFromParent = SKAction.removeFromParent()
        let chompAction = SKAction.sequence([fadeIn, groupAction, removeFromParent])
        chomp.run(chompAction)
      }
    }

    // Or did the [COLLECTIBLE] collide with the [FOREGROUND]?
    if collision == PhysicsCategory.foreground | PhysicsCategory.collectible {
      // print("collectible hit foreground")
      
      // Find out which body is attached to the collectible node
      let body = contact.bodyA.categoryBitMask == PhysicsCategory.collectible ?
        contact.bodyA.node :
        contact.bodyB.node

      // Verify the object is a collectible
      if let sprite = body as? Collectible {
        sprite.missed()
        gameOver()
      }
    }
  }
}

extension GameScene {
  func setupContinues() {
    watchAdButton.name = "watchAd"
    watchAdButton.setScale(0.75)
    watchAdButton.zPosition = Layer.ui.rawValue
    watchAdButton.position = CGPoint(x: startGameButton.frame.maxX + 75,
                                     y: startGameButton.frame.midY - 25)
    watchAdButton.alpha = 0.0
    addChild(watchAdButton)
    
    continueGameButton.name = "continue"
    continueGameButton.setScale(0.85)
    continueGameButton.zPosition = Layer.ui.rawValue
    continueGameButton.position = CGPoint(x: frame.maxX - 75,
                                          y: viewBottom() + 60)
    addChild(continueGameButton)
    
    updateContinueButton()
  }
  
  func updateContinueButton() {
    if numberOfContinues > maxNumberOfContinues {
      let texture = SKTexture(imageNamed: "continueRemaining-max")
      continueGameButton.texture = texture
    } else {
      let texture = SKTexture(imageNamed:
        "continueRemaining-\(numberOfContinues)")
      continueGameButton.texture = texture
    }
  }
  
  func useContinue() {
    /* Verify that the player has at least 1 continue.
     If so, reduce the continues by 1, first by checking the free
     continues. If no free continues exist, check the paid continues. */
    
    if numberOfContinues > 0 {
      
      // Check from where to pull
      if numberOfFreeContinues > 0 {
        numberOfFreeContinues -= 1
      } else if numberOfPaidContinues > 0 {
        numberOfPaidContinues -= 1
      }
      
      // Continue game
      isContinue = true
      spawnMultipleGloops()
    }
  }
  
  func setupShop() {
    // Set up Shop Button
    shopButton.name = "shop"
    shopButton.zPosition = Layer.shop.rawValue
    shopButton.position = CGPoint(x: frame.minX + 75, y: viewBottom() + 75)
    addChild(shopButton)
    
    // Set up Shop Scene and add it to the Game Scene
    shopScene = ShopScene(in: self)
    shopScene.zPosition = Layer.shop.rawValue
    shopScene.position = CGPoint(x: frame.midX, y: frame.midY)
    addChild(shopScene!)
    
    // Set up notification observers and Shop UI
    shopScene.setupObservers()
    shopScene.setupShop()
  }
}
