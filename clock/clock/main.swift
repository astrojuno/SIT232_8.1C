//  SIT232 8.1C Clock
//  John Ryder 219466419
//
//  main.swift
//  clock
//
//  A direct implimentation of the 2.3C task in Swift
//
//  Created by John Ryder on 12/9/20.
//  Copyright © 2020 John Ryder. All rights reserved.
//

// similar to using System, Foundation is the base tools in Swift
import Foundation

// in swift structs are value types, whereas classes are reference types. This means to get
// some of the things we'd expect from a class in C#, we'll use a struct here. An example
// would be copying. If you copy a class in swift you get a pointer to it, but if you
// copy a struct you get a new struct.
public struct Clock {
    // Variables
    // variables work in a similar way to C#, there's just a different syntax for them
    private var hour = 00
    private var minute = 00
    private var second = 00
    
    // Constructor to set default time
    init() {
        setTime(00, 00, 00)
    }
    
    // Constructor to set specific time
    init(hour: Int, minute: Int, second: Int) {
        if(checkHour(hour) && checkMinute(minute) && checkSecond(second)) {
            // swift uses self instead of this
            setTime(hour, minute, second)
        } else {
            // swift uses print instead of Console.WriteLine
            print("Incorrect format given. Time has been created at 00:00:00")
            setTime(00, 00, 00)
        }
    }
    
    // Public Methods
    // Getters
    // methods are very similar, but with different syntax. I like the way the return is
    // specified, I think it makes it very obvious and human readable.
    public func getHour() -> Int {
        return self.hour
    }
    
    // swift will do a great job of inferring, so we can really start to reduce the amount
    // of code required
    public func getMinute() -> Int {
        self.minute
    }
    
    // down to one line functions
    public func getSecond() -> Int { second }
    
    // returns the current time object in a human readable string
    // there is no default ToString in swift, so we don't need to override it
    public func toString() -> String {
        // we can concatenate strings too...
        return(String(format: "%02d:%02d:%02d", hour, minute, second))
    }
    
    // Setters
    // set the time
    public mutating func setTime(_ hour: Int, _ minute: Int, _ second: Int) {
        if(checkHour(hour) && checkMinute(minute) && checkSecond(second)) {
            // swift uses self instead of this
            self.hour = hour
            self.minute = minute
            self.second = second
        } else {
            formatError()
        }
    }
    
    // set the hour
    public mutating func setHour(_ hour: Int) {
        if(checkHour(hour)) {
            setTime(hour, minute, second)
        } else {
            formatError()
        }
    }
    
    // set the minutes
    public mutating func setMinute(_ minute: Int) {
        if(checkMinute(minute)) {
            setTime(hour, minute, second)
        } else {
            formatError()
        }
    }
    
    // set the seconds
    public mutating func setSecond(_ second: Int) {
        if(checkSecond(second)) {
            setTime(hour, minute, second)
        } else {
            formatError()
        }
    }
    
    // incriments the time by one second
    public mutating func myNextSecond() {
        second += 1
        // if this is no longer valid, we've incrimented from 59 to 60
        if(!checkSecond(second)) {
            // set the seconds to 0 and incriment the minute
            second = 0
            myNextMinute()
        }
    }
    
    // decrements teh seconds by one seconds
    public mutating func myPreviousSecond() {
        second -= 1
        // if this is no longer valid, we've decrimented from 0 to -1
        if(!checkSecond(second)) {
            // set the seconds to 59 and decriment the minute
            second = 59
            myPreviousMinute()
        }
    }
    
    // incriment the time by one minute
    public mutating func myNextMinute() {
        minute += 1
        // if this is no longer valid, we've incrimented from 59 to 60
        if(!checkMinute(minute)) {
            // set the minutes to 0 and incriment the hour
            minute = 0
            myNextHour()
        }
    }
    
    // decriment the minutes by one minute
    public mutating func myPreviousMinute() {
        minute -= 1
        // if this is no longer valid, we've decrimented from 0 to -1
        if(!checkMinute(minute)) {
            // set the minutes to 59 and decriment the hour
            minute = 59
            myPreviousHour()
        }
    }
    
    // incriment the time by one hour
    public mutating func myNextHour() {
        hour += 1
        // if this is no longer valid, we've incrimented from 59 to 60
        if(!checkHour(hour)) {
            // set the hours to 0 (midnight)
            hour = 0
        }
    }
    
    // decriment the time by one hour
    public mutating func myPreviousHour() {
        hour -= 1
        // if this is no longer valid, we've decrimented from 0 to -1
        if(!checkHour(hour)) {
            // set the hour to 23
            hour = 23
        }
    }
    
    // Private Methods
    // check the given hour, minute or second to make sure it's compliant
    private func checkHour(_ hour: Int) -> Bool {
        ((0 <= hour) && (hour <= 23))
    }
    
    // we could have generalised the minutes to (say) checkZeroToFiftyNine and used it for both, but this
    // is more human readable...
    private func checkMinute(_ minute: Int) -> Bool {
        ((0 <= minute) && (minute <= 59))
    }
    
    private func checkSecond(_ second: Int) -> Bool {
        ((0 <= second) && (second <= 59))
    }
    
    // prints the general format error
    private func formatError() {
        print("Incorrect format given. Time has not been changed.")
    }
}

// let's run some tests to be sure
print("Testing MyTime...")
            
print("Creating new object with default initializer...")
var midnightClock = Clock()

print("Testing getters...")
print("Hour: \(midnightClock.getHour())")
print("Minute: \(midnightClock.getMinute())")
print("Second: \(midnightClock.getSecond())")
print("ToString: \(midnightClock.toString())")

print()

print("Testing setters...")
print("Hour to 1, minute to 45, seconds to 7...")
midnightClock.setHour(1)
midnightClock.setMinute(45)
midnightClock.setSecond(7)
print("New time: \(midnightClock.toString())")

print()

print("New object at 15:22:56...")
var afternoonClock = Clock(hour: 15, minute: 22, second: 56)
print(afternoonClock.toString())
print("Setting this time to 23:59:59...")
afternoonClock.setTime(23, 59, 59)
print(afternoonClock.toString())

print("Testing incrimenting...")
print(afternoonClock.toString())
afternoonClock.myNextSecond()
print(afternoonClock.toString())
print("Testing decrimenting...")
afternoonClock.myPreviousSecond()
print(afternoonClock.toString())
