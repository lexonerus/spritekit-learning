# Val's Revenge Pathfinding Challenge

For this challenge, you'll have very little guidance. But don't worry---if you get stuck, you can always look at the solution to get some ideas.

Here's the general overview of what you need to do:

1. Create a Swift file (`PathFindingComponent.swift`) for your new component, saving it in the `Components` group.

2. Add an `agent` and an `isRunning` property to the class.

3. Create two methods: one to handle starting the pathfinding routine, and one to stop it. For the starting method, you can copy the code from the `startAdvancedNavigation()` method (in the `GameScene` class); however, you'll need to make a few changes. For example, you may want to start the new method like so:

    ```
    guard let scene = componentNode.scene as? GameScene,
      let sceneGraph = scene.graphs.values.first else {
        return
    }
    ```

4. Finally, override the `update(deltaTime:)` method to handle the starting and stopping based on the current state of the `mainGameStateMachine` state machine.

5. Ensure your new component will work when using it in the Scene Editor:

    ```
    override class var supportsSecureCoding: Bool {
      true
    }
    ```

6. Remove all of the pathfinding code in the `GameScene`.

7. In the Scene Editor, attach the new component to the `key` node. 