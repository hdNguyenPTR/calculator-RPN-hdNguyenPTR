//
//  ErrorHandling.swift
//  calc
//
//  Created by VM on 8/4/19.
//  Copyright © 2019 UTS. All rights reserved.
//

import Foundation

// function for checking errors
func checkError(input: [String]) throws -> [String]
{
    // check for no operator errors
    guard (input.count < 2 || input.contains(where: ["+", "-", "/", "%", "x"].contains)) else
    {
        throw CalculatorErrors.noOperators
    }
    // check for invalid inputs
    for str in input
    {
        guard (Int(str) != nil || str == "+" || str == "-"
            || str == "x" || str == "%" || str == "/") else
        {
            throw CalculatorErrors.invalidValues
        }
    }    
    return input
}
