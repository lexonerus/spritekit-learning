# Add Support for External Game Controllers

Sadly, there wasn't enough room in this book to directly cover the topic of external game controllers, but I wanted to include the code should you decide to add support to your games.

To support external game controllers, you use the `GameController` framework. For more information about that framework, please refer to Apple's online documentation: https://developer.apple.com/documentation/gamecontroller

Here's a quick overview on how to get external controller support for Val's Revenge: 

1. Copy the `GameScene+GameController.swift` file into the project's `Extensions` group.

2. Open the `Controller.swift` file, and add the following new method:

    ```
    func getRange() -> CGFloat {
      return range
    }
    ```
	
	The `range` property is a private var, so you need a public way to retrieve that value.

3. In the `didMove(to:)` method of the `GameScene` class, add the following code at the top:

    ```
    observeForGameControllers()
    ```
	
That's it! Enjoy.