In Xcode 12, when building to a physical device, you may experience a significant launch delay that could last a few seconds to several minutes. In some cases, you may never get past this point.

To resolve this problem, you need to disable the `Debug executable` option in both the `Run` and `Test` scheme actions. Here's how:

1. From Xcode's App menu, select `Product ▶ Scheme ▶ Edit Scheme...`.
2. Select the `Run` scheme action from the left column.
3. Update the scheme action's settings by unchecking the `Debug executable` option shown in the `Info` tab.

Repeat this process for the `Test` scheme action.

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

What does the "Debug executable" option do?

"Select the “Debug executable” checkbox if you want to run with the debugger enabled. With the debugger running, you can use Debug > Attach to Process on a process that has been launched with debugging disabled, if needed." — Apple
