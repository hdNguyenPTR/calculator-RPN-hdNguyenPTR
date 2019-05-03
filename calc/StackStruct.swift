//
//  StackStruct.swift
//  calc
//
//  Created by VM on 4/4/19.
//  Copyright © 2019 UTS. All rights reserved.
//

import Foundation

// Structure for Stack functions, inspired by a simple RPN calculator https://gist.github.com/8of/0103068289d9f034e62ebaf4e97672cc
struct Stack<T>
{
    let values: [T]
    
    init(_ v: [T] = [T]())
    {
        self.values = v
    }
    
    // check for empty stack
    var isEmpty: Bool
    {
        return values.isEmpty
    }
    
    // function to push value into stack
    func push(elem: T) -> Stack<T>
    {
        let newValues = self.values + [elem]
        return Stack<T>(newValues)
    }
    
    // function to pop last value of stack
    func popLast() -> (T?, Stack<T>)
    {
        if self.values.isEmpty
        {
            return (nil, self)
        }
        let cnt = self.values.count
        let newPopValues = self.values[0..<cnt-1]
        return (self.values[cnt-1], Stack<T>(Array(newPopValues)))
    }
    
    //function to pop first value of stack
    func popFirst() -> (T?, Stack<T>)
    {
        if self.values.isEmpty
        {
            return (nil, self)
        }
        let first = self.values.first
        let cnt = self.values.count
        let newPullValues = self.values[1..<cnt]
        return (first, Stack<T>(Array(newPullValues)))
    }
}
