//
//  ReversePolishNotation.swift
//  calc
//
//  Created by VM on 6/4/19.
//  Copyright © 2019 UTS. All rights reserved.
//

import Foundation

// RPN Calculator Class
class ReversePolishNotationCalculator
{
    // function to convert infix notation to Reverse Polish Notation
    func RPNConversion(input: [String]) -> Stack<String>
    {
        // variable declaration
        var RPNOutput = Stack<String>()
        var RPNOperator = Stack<String>()
        // precedence and association variables
        var lowPrecedence: Bool = true
        var lowAssociative: Bool = false
        var highAssociative: Bool = false
        
        // algorithm to convert infix to RPN notation
        for (str) in input
        {
            // switch function used to analyse each string str in input array
            switch(str)
            {
            // case for high precedence operators
            case "x","/","%":
                // set precedence to high and remove + and - associative value
                lowPrecedence = false
                lowAssociative = false
                // where to place operators, check for association
                if(!highAssociative)
                {
                    // push to operator stack
                    RPNOperator = RPNOperator.push(elem: str)
                    // keep association
                    highAssociative = true
                }
                else
                {
                    // pop from operator stack
                    RPNOutput = RPNOutput.push(elem: RPNOperator.popLast().0!)
                    RPNOperator = RPNOperator.popLast().1
                    RPNOperator = RPNOperator.push(elem: str)
                }
            //case for low precedence operators
            case "+","-":
                // remove x / % associative
                highAssociative = false
                // where to place operators when there is no high precedence
                if (lowPrecedence)
                {
                    // check for association
                    if(!lowAssociative)
                    {
                        // push to operator stack
                        RPNOperator = RPNOperator.push(elem: str)
                        // keep association
                        lowAssociative = true
                    }
                    else
                    {
                        // pop from operator stack
                        RPNOutput = RPNOutput.push(elem: RPNOperator.popLast().0!)
                        RPNOperator = RPNOperator.popLast().1
                        RPNOperator = RPNOperator.push(elem: str)
                    }
                }
                // where to place operators when there is high precedence
                else
                {
                    // pop all from operator stack
                    while(!RPNOperator.isEmpty)
                    {
                        RPNOutput = RPNOutput.push(elem: RPNOperator.popLast().0!)
                        RPNOperator = RPNOperator.popLast().1
                    }
                    RPNOperator = RPNOperator.push(elem: str)
                    // set precedence to low
                    lowPrecedence = true
                }
            default:
                // where to put all int values
                RPNOutput = RPNOutput.push(elem: str)
            }
        }
        // final pop from operator stack to output stack
        while(!RPNOperator.isEmpty)
        {
            RPNOutput = RPNOutput.push(elem: RPNOperator.popLast().0!)
            RPNOperator = RPNOperator.popLast().1
        }
        return RPNOutput
    }
    
    // function to perform RPN calculations
    func solveRPN(expr: Stack<String>) -> Int
    {
        // variable declaration
        var start: Stack<String> = expr
        var temp: String
        var calStack = Stack<Int>()
        
        // while used to perform calculation on all values
        while(!start.isEmpty)
        {
            // variable declarations
            temp = (start.popFirst().0!)
            let (rightValue, stk1) = calStack.popLast()
            let (leftValue, stk2) = stk1.popLast()            
            
            // switch case to calculate each temp values popped
            switch(temp)
            {
            case "+":
                calStack = stk2.push(elem: leftValue! + rightValue!)
            case "-":
                calStack = stk2.push(elem: leftValue! - rightValue!)
            case "x":
                calStack = stk2.push(elem: leftValue! * rightValue!)
            case "/":
                calStack = stk2.push(elem: leftValue! / rightValue!)
            case "%":
                calStack = stk2.push(elem: leftValue! % rightValue!)
            default:
                calStack = calStack.push(elem: Int(temp)!)
            }
            // get new stack
            start = start.popFirst().1
        }
        // return final result
        return calStack.popFirst().0!
    }

    // function to combine RPN conversion and calculation
    func calculate(arg: [String]) -> Int
    {
        return solveRPN(expr:(RPNConversion(input: arg)))
    }
}
