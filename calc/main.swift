//
//  main.swift
//  calc
//
//  Created by Jesse Clark on 12/3/18.
//  Copyright © 2018 UTS. All rights reserved.
//

import Foundation

var args = ProcessInfo.processInfo.arguments
args.removeFirst() // remove the name of the program

// declare values
let calculator = ReversePolishNotationCalculator()
var testInput: [String]

// run error checks
do
{
    try testInput = checkError(input: args)
    print(calculator.calculate(arg: testInput))
}
// catch invalid input errors
catch CalculatorErrors.invalidValues
{
    print("Invalid Input")
    exit(1)
}
// catch no operators errors
catch CalculatorErrors.noOperators
{
    print("No Operators")
    exit(2)
}
// catch other errors
catch let error
{
    print("Unspecified Error: \(error)")
    exit(3)
}


