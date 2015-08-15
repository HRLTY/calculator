//
//  ViewController.swift
//  Calculator
//
//  Created by huangrui on 8/11/15.
//  Copyright © 2015 HRLTY. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var history: UILabel!
    @IBOutlet weak var display: UILabel!
    var userIsTheMiddleOfTypingANumber = false
    @IBAction func clearAll()
    {
        history.text = ""
        displayValue = 0
        operandStack = []
    }
    @IBAction func appendDigit(sender: UIButton)
    {
        let digit = sender.currentTitle!
        if userIsTheMiddleOfTypingANumber{
            if digit != "." || display.text!.rangeOfString(".") == nil{
                display.text = display.text! + digit
            }
        }else{
            display.text = digit
            userIsTheMiddleOfTypingANumber = true
        }

    }
    var operandStack = Array<Double>()


    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsTheMiddleOfTypingANumber{
            enter()
        }
        if operation != "π"{
            history.text = history.text! + operation + "\n"
        }
        switch operation {
        case "+": performOperation { $0 + $1 }
        case "−": performOperation { $1 - $0 }
        case "×": performOperation { $0 * $1 }
        case "÷": performOperation { $1 / $0 }
        case "√": performOperation { sqrt($0)}
        case "sin": performOperation {sin($0)}
        case "cos": performOperation {cos($0)}
        case "π": enter(M_PI)
        default: break
        }
    }
    
    func performOperation(operation: (Double, Double) -> Double){
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    private func performOperation(operation: Double -> Double){
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    @IBAction func enter() {
        userIsTheMiddleOfTypingANumber = false
        operandStack.append(displayValue)
        history.text = history.text! + "\(displayValue)\n"
        print("operandStack = \(operandStack)")
    }
    private func enter(const:Double) {
        displayValue = const
        enter()
    }
    var displayValue: Double{
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            display.text = "\(newValue)"
            userIsTheMiddleOfTypingANumber = false
        }
    }

}

