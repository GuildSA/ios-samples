
import UIKit


// Functions with Multiple Return Values

// You can use a tuple type as the return type for a function to return multiple
// values as part of one compound return value.

func getTheHighScore() -> (name: String, score: Int) {
    
    // Pretned that we went out to our game server and brought back this data!
    let theName = "Chris"
    let theScore = 75200
    
    return (theName, theScore)
}

let highScoreData = getTheHighScore()

print("The high score is \(highScoreData.score) held by \(highScoreData.name)")


//------------------------------------------------------------------------------

// We can also use the keyword "typealias" to name tuple types. We can then use
// these name as a return type for our own functions.

typealias HighScore = (name: String, score: Int)

func getTheHighScore2() -> HighScore {
    
    // Pretned that we went out to our game server and brought back this data!
    let theName = "Jennifer"
    let theScore = 89500
    
    return (theName, theScore)
}

let highScoreData2: HighScore = getTheHighScore2()

print("The high score is \(highScoreData2.score) held by \(highScoreData2.name)")


//------------------------------------------------------------------------------

// Variadic Parameters

// A variadic parameter allow us to pass zero or more values of a specified
// type, and then get access to them.

func addAllNumbers(numbers: Int...) -> Int {
    
    var total: Int = 0
    
    for number in numbers {
        total += number
    }
    
    return total
}

addAllNumbers(1, 2, 3, 4, 5)

//------------------------------------------------------------------------------

// In-Out Parameters

// By default, parameters are constants and their values can not be changed.
// For example, the following function will not compile under Swift because it
// is attempting to change the parameter called someNumber.

//func doSomething(someNumber: Int) {
//    someNumber = 42 // Forbidden!
//}

// But there are times when we want the ability to change the values held by
// the variables that were passed into the function. To support this we mark
// the parameters that can be changed as inout parameters.

func swapTwoInts(inout a: Int, inout _ b: Int) {
    
    let temp = a // Let 'temp' hold the value of 'a'.
    a = b        // Set 'a' to whatever 'b' is.
    b = temp     // Finally, set 'b' to what 'a' was.
}

var var1 = 42
var var2 = 1000

print("var1 = \(var1), and = \(var2)") // Before Swap

// To pass an argument that can be changed inside the function, we must put
// an '&' charcater in front of it.

swapTwoInts( &var1, &var2 )

print("var1 = \(var1), var2 = \(var2)") // After Swap


//------------------------------------------------------------------------------

// Nested Functions

// It's possible to declare a function inside another function and then use it!

func processNumbers(number1: Int, _ number2:Int) -> Int {
    
    func add(a: Int, _ b: Int) -> Int {
        return a + b
    }
    
    return add(number1, number2)
}

let result = processNumbers(1, 2)

print(result)

//------------------------------------------------------------------------------

// It's also possible to declare functions inside of another function
// and then return it so it can be used externally.

func getCustomFunction(functionId: Int) -> (Int, Int) -> Int {
    
    func add(a: Int, b: Int) -> Int {
        return a + b
    }
    
    func subtract(a: Int, b: Int) -> Int {
        return a - b
    }
    
    func multiply(a: Int, b: Int) -> Int {
        return a * b
    }
    
    func divide(a: Int, b: Int) -> Int {
        return a / b
    }
    
    if functionId == 0 {
        return add
    } else if functionId == 1 {
        return subtract
    } else if functionId == 2 {
        return multiply
    } else {
        return divide
    }
}

let computeFunction = getCustomFunction(0)

var answer = computeFunction(1, 2)

print(answer)
