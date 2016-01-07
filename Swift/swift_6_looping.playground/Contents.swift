
import UIKit

// For-In looping

// You can use the for-in loop to iterate over a sequence, such as ranges of
// numbers, items in an array, or characters in a string.

// This example uses a range of numbers to print out a test message 4 times.

for index in 0...3 {
    print("Current index is: \(index)")
}

// This for-in loop also uses a range of numbers to print out a test message, 
// but calls reverse on it to print the index values in reverse order.
for index in (0...3).reverse() {
    print("Current index is: \(index)")
}

//------------------------------------------------------------------------------

// This example iterates over an array of player weapons.

var weaponsList = ["Dagger", "Sword", "Club"]

for weapon in weaponsList {
    print("Player has a \(weapon)!")
}

//------------------------------------------------------------------------------

// This example iterates over an dictionary of player's names and scores.

var playerScores = [
    "Calvin": 2100,
    "Jennifer": 2700,
    "Debbie": 3000,
]

for (name, score) in playerScores {
    print("\(name) scored \(score) points.")
}

//------------------------------------------------------------------------------

// String provides a characters property that exposes a character collection
// view which can be used to feed data to a For-In loop.

var myString = "LOL"

for character in myString.characters {
    print(character)
}

//------------------------------------------------------------------------------

// In addition to for-in loops, Swift supports traditional C-style for loops
// with a condition and an incrementer.

for var index = 0; index < 3; ++index {
    print("Index: \(index)")
}

// This can be very useful when you want to create a for loop that increments
// in an unusual way, such as this one that starts at 2, increments by 2 as
// in 2,4,6,8 and stops at 8.
for var i = 2; i < 10; i = i + 2 {
    print("Index: \(i)")
}


//------------------------------------------------------------------------------

// If you don’t need the index variable, you can ignore the values by using an
// underscore in place of a variable name.

for _ in 1...3 {
    print("Bang!")
}

//------------------------------------------------------------------------------

// The while loop continues looping while the expression is true.

let numRocketsToFire = 3
var rocketCount = 0

while rocketCount < numRocketsToFire {
    
    ++rocketCount
    
    print( "Firing rocket #\(rocketCount)" )
}

//------------------------------------------------------------------------------

// We can use the 'break' keyword to break out of a while loop early if we find
// a reason to.

var number = 0

while number < 10 {
    
    print( "while-break test \(number) " )
    
    if number == 5 {
        
        // If the number is 5 - stop looping and jump out of the loop's body!
        break
    }
    
    ++number
}

//------------------------------------------------------------------------------

// The 'continue' keyword allows us to skip the rest of the loop's body and jump
// to the loop's top.

var answer = 0

while answer < 100 {
    
    ++answer
    
    if answer != 42 {
        
        // If the answer is not equal to 42 - keep looping, but jump straight
        // back to the top!
        continue
    }
    
    print("We just found it... The Answer to the Ultimate Question of Life, the Universe, and Everything!")
}

//------------------------------------------------------------------------------

// Repeat-While

// The other variation of the while loop, known as the repeat-while loop,
// performs a single pass through the loop block first, before considering the
// loop’s condition. It then continues to repeat the loop until the condition
// is false.

number = 0

repeat {
    
    print( "repeat-while test \(number)" )
    
    ++number
    
} while number < 5



