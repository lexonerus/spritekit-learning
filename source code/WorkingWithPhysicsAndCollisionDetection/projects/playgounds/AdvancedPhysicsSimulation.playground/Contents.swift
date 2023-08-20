import PlaygroundSupport
import SpriteKit

class GameScene: SKScene {
  
  // MARK: - PROPERTIES
  
  // Set up nodes for use with toggle option
  var physicsToggle: SKShapeNode {
    // Set up a rectangle shape node with corner radius to use as a button
    let button = SKShapeNode(rectOf: CGSize(width: 350, height: 50), cornerRadius: 10.0)
    button.strokeColor = SKColor.lightGray
    button.fillColor = SKColor.lightGray
    button.position = CGPoint(x: frame.midX, y: frame.maxY - 100)
    
    // Set up a label node to show the current toggle option
    let label = SKLabelNode(text: "Physics Bodies: OFF")
    label.name = "physicsLabel"
    label.fontName = "AvenirNext-Medium"
    label.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
    
    button.addChild(label) // add label to button node
    
    return button
  }
  
  // Set up property to hold currently selected toggle option
  var withBody: Bool = false {
    didSet { // use a property observer to update the label node
      if let label = scene?.childNode(withName: "//physicsLabel") as? SKLabelNode {
        if withBody == true {
          label.text = "Physics Bodies: ON"
          clearShapes()
        } else {
          label.text = "Physics Bodies: OFF"
          clearShapes()
        }
      }
    }
  }
  
  var addJoints: Bool = true
  /* Set this property to `true` and review the `setupJoints()` method
   to play with the more advanced features of the SpriteKit physics engine,
   which is out of scope for this book. */
  
  // MARK: - MAIN METHODS
  
  override func didMove(to view: SKView) {
    
    print("You are running an advanced physics simulation in an Xcode playground.")
    
    // Add the physics body toggle button (rectangle shape node)
    addChild(physicsToggle)
    
    // Set up a rectangle shape node to use for the floor
    let floor = SKShapeNode(rectOf: CGSize(width:frame.width - 50, height: 50))
    floor.name = "floor"
    floor.fillColor = SKColor.gray
    floor.alpha = 1.0
    
    // Set its position to be near the bottom of the scene
    floor.position = CGPoint(x: frame.midX, y: frame.minY + 50)
    
    // Set up its physics body using a rectangle
    floor.physicsBody = SKPhysicsBody(rectangleOf: floor.frame.size)
    floor.physicsBody?.isDynamic = false // static, not moved by physics engine
    floor.physicsBody?.affectedByGravity = false // ignores world gravity
    
    // Add the floor node to the scene
    addChild(floor)
    
    // Set up a circle shape node in the middle of the scene
    let circle = SKShapeNode(circleOfRadius: 25)
    circle.name = "circle"
    circle.fillColor = SKColor.orange
    
    // Set its position to the center of the scene
    circle.position = CGPoint(x: frame.midX, y: frame.midY)
    
    // Set up its physics body using a circle
    circle.physicsBody = SKPhysicsBody(circleOfRadius: circle.frame.width/2)
    circle.physicsBody?.isDynamic = false // static, not moved by physics engine
    circle.physicsBody?.affectedByGravity = false // ignores world gravity
    
    // Add the circle node to the scene
    addChild(circle)
    
    // Set up a physics body around the frame using an edge loop
    physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
    
    if addJoints == true {
      setupJoints()
    }
  }
  
  func clearShapes() {
    
    print("Clear shapes and start over.")
    
    // Find all shape nodes named ball and remove them from the scene
    enumerateChildNodes(withName: "//ball") { node, stop in
      if let sprite = node as? SKShapeNode {
        sprite.removeFromParent()
      }
    }
    
    // Reset floor
    if let floor = childNode(withName: "//floor") as? SKShapeNode {
      floor.position = CGPoint(x: frame.midX, y: frame.minY + 50)
    }
    
    // Reset circle
    if let circle = childNode(withName: "//circle") as? SKShapeNode {
      circle.position = CGPoint(x: frame.midX, y: frame.midY)
    }
  }
  
  // MARK: - TOUCH HANDLING
  
  func touchDown(atPoint pos: CGPoint) {
    
    print("You touched the scene at point: \(pos)")
    
    // Check if toggle button was clicked
    if physicsToggle.contains(pos) {
      withBody.toggle()
      return
    }
    
    // Set up a circle shape node to use for the ball
    let ball = SKShapeNode(circleOfRadius: 50)
    ball.name = "ball"
    ball.position = pos
    
    // Check value of `withBody` to determine if physics is enabled
    if withBody == true {
      ball.fillColor = SKColor.white
      ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.frame.width/2)
      
      // Set up physics properties
      ball.physicsBody?.restitution = 0.2 // Bounce: 0.0-1.0 (default: 0.2)
      ball.physicsBody?.mass = 20 // in kilograms
    }
    
    // Add the ball node to the scene
    addChild(ball)
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    for t in touches { touchDown(atPoint: t.location(in: self)) }
  }
  
  // MARK: - ADVANCED PHYSICS
  func setupJoints() {
    
    print("Set up the joints.")
    
    // Find the circle node
    if let circle = childNode(withName: "//circle") as? SKShapeNode {
      
      // Set up a new rectangle shape
      let rectangle = SKShapeNode(rectOf: CGSize(width: 300, height: 25))
      rectangle.name = "rectangle"
      rectangle.fillColor = SKColor.lightGray
  
      // Set its position
      rectangle.position = CGPoint(x: frame.midX, y: frame.midY - 150)
      
      // Add a physics body to the rectangle shape
      rectangle.physicsBody = SKPhysicsBody(rectangleOf: rectangle.frame.size)
      
      // Add the rectangle to the scene
      addChild(rectangle)
      
      // Set up a spring joint and connect it to two bodies (circle/rectangle)
      let chain = SKPhysicsJointSpring.joint(withBodyA: circle.physicsBody!,
                                             bodyB: rectangle.physicsBody!,
                                             anchorA: circle.position,
                                             anchorB: rectangle.position)
      
      // Set some properties for the joint
      chain.damping = 1.0
      chain.frequency = 1.0
      
      // Add the joint to the physics world
      physicsWorld.add(chain)
    }
  }
}

// Set up the scene
let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 384, height: 512))
if let scene = GameScene(fileNamed: "GameScene") {
  scene.scaleMode = .aspectFill
  sceneView.showsPhysics = true // show the physics bodies
  sceneView.presentScene(scene)
}

// Add playground support
PlaygroundSupport.PlaygroundPage.current.liveView = sceneView
