# Debugging in Visual Studio

## Starting in Debug Mode

By default when you run your application in Visual Studio, it will run in Debug Mode. 

You can tell your application is running in debug mode, because the status bar at the bottom of the Visual Studio window will turn from blue to orange.


## Breakpoints

A breakpoint is a location in your code where you want to pause execution so you can examine the state of your application.

To set a breakpoint click on the vertical margin to the left of the Code Editor window. A red dot will appear in the margin and the code at that line will be highlighted in red.

To remove a breakpoint, click the red dot in the margin.

![Breakpoints](./images/breakpoint.gif)

**Further reading**
[Use Breakpoints in the Visual Studio Debugger](https://docs.microsoft.com/en-us/visualstudio/debugger/using-breakpoints?view=vs-2017)

## Autos and Locals Window

When you are stopped on a breakpoint Studio, you can view the values of your variables with the Autos and Locals windows.

![Autos and Locals](./images/autos_locals.gif)

**Further reading**
[Autos and Locals Windows](https://docs.microsoft.com/en-us/visualstudio/debugger/autos-and-locals-windows?view=vs-2017).

## Immediate Window

The Immediate window is used to debug and evaluate expressions, execute statements, print variable values, and so forth. It allows you to enter expressions to be evaluated or executed during debugging.

![Immediate Window](./images/immediate.gif)

**Further reading**
[Immediate Window](https://docs.microsoft.com/en-us/visualstudio/ide/reference/immediate-window?view=vs-2017)

## Call Stack

Use the callstack to view the entire execution "path" to the code up to the breakpoint.

![Callstack](./images/callstack.gif)

**Further reading**
[Call Stack Window](https://docs.microsoft.com/en-us/visualstudio/debugger/how-to-use-the-call-stack-window?view=vs-2017).

## More Debugging Windows

There are more windows that you can use while debugging your application. To see the entire list, and read more about each one, read the [Learn about Debugger Windows in Visual Studio](https://docs.microsoft.com/en-us/visualstudio/debugger/debugger-windows?view=vs-2017) article.


## Further Reading
* https://tutorials.visualstudio.com/vs-get-started/debugging
* https://docs.microsoft.com/en-us/visualstudio/debugger/navigating-through-code-with-the-debugger?view=vs-2017 
* [Getting Started with the Debugger](https://msdn.microsoft.com/en-us/library/k0k771bt.aspx).
