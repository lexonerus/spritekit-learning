# Gloop Drop Code Challenge

You've come along way since starting this book. You learned how to create scenes using different types of nodes. You added actions to these nodes to make them come alive. You played with physics and collision detection. And you even added some neat audiovisual effects. You're now ready to take what you've learned and give it a go on your own.

Your task is to add the additional resources and set up an action that makes a little spaceship with a robot in it fly across the scene at random intervals and to add a new particle effect. You'll also add a little something to the player node to make it easier to move and see Blob. Try to do this challenge on your own.

If you get stuck, review the completed challenge project for help---or to compare your solution. When you're done, you'll end up with something like this:

![](images/JuicingYourGamesWithSoundAndEffects/spritekit-build-challenge.png)

## Adding the Star Particles

Your first challenge is to create a new particle effect that looks like stars and add it to the scene. Alternatively, you can drag the `challenge/resources/Stars.sks` particle effect file into the project and use that.

If you get stuck, follow the steps below.

### Add the Emitter Node

1. Create a new particle file or copy the example into the project.
2. Open the `GameScene.swift` file.
3. Add the following code at the end of the `didMove(to:)` method:

{:language="swift"}
~~~
// Challenge: Set up star particles
if let stars = SKEmitterNode(fileNamed: "Stars.sks") {
  stars.name = "stars"
  stars.position = CGPoint(x: frame.midX, y: frame.midY)
  addChild(stars)
}
~~~

## Adding the Spaceship and Robot

Your next challenge is to add a robot piloting a spaceship that periodically moves across the scene every 30-60 seconds.

If you get stuck, follow the steps below.

### Add the Assets

1. Create a new sprite atlas, and name it `extras`.
2. Delete the default `Sprite` image set.
3. Drag the robot image assets into the newly created `extras` sprite atlas.
4. Drag the robot sound file into the existing `Sounds` group.

### Create the Method to Move the Robot/Spaceship

1. Open the `GameScene.swift` file.
2. Create a new method below the `hideMessage()` method that handles moving the robot:

{:language="swift"}
~~~
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
~~~

3. Call the new `sendRobot()` method at the end of the `didMove(to:)` method:

{:language="swift"}
~~~
// Challenge: Create an action to run after a short random delay
let wait = SKAction.wait(forDuration: 30, withRange: 60)
let codeBlock = SKAction.run({self.sendRobot()})
run(SKAction.sequence([wait, codeBlock]))
~~~

## Updating the Player Node

Your next challenge is to add a new crosshairs sprite node to the player node, positioning it slightly above the player sprite with an alpha setting of `0.25`. 

After that, you need to add a controller sprite node using and position this new node just below the player sprite. You also need to increase the size of the player "hit area" by adding a clear shape node.

If you get stuck, follow the steps below.

1. Drag the three `crosshairs` images and the three `ring` images into the `blob` sprite atlas.
2. Open the `Player.swift` file, and add the following to code to the end of the `init()` method:

{:language="swift"}
~~~
// Add crosshairs
let crosshairs = SKSpriteNode(imageNamed: "crosshairs")
crosshairs.name = "crosshairs"
crosshairs.position = CGPoint(x: 0.0, y: size.height * 2.12)
crosshairs.alpha = 0.25
self.addChild(crosshairs)

// Add controller ring
let moveController = SKSpriteNode(imageNamed: "controller")
moveController.zPosition = Layer.player.rawValue
moveController.position = CGPoint(x: 0, y: -51)
moveController.name = "controller"
self.addChild(moveController)
    
// The player hit marker was too small; this makes it easier to control
let playerController = SKShapeNode(rect: CGRect(x: -self.size.width/1.5,
                                             y: 0.0, 
										     width: self.size.width * 1.5,
										     height: self.size.height * 1.5))
    
playerController.name = "controller"
playerController.fillColor = .clear
playerController.alpha = 1.0
playerController.strokeColor = .clear
playerController.zPosition = Layer.player.rawValue
self.addChild(playerController)
~~~

3. Open the `GameScene.swift` file, and locate the following line:

~~~
if touchedNode.name == "player" {
~~~

Then, change it to this:

~~~
if touchedNode.name == "player" || touchedNode.name == "controller" {
~~~