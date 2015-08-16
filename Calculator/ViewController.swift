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
    var brain = CalculatorBrain()
    var userIsTheMiddleOfTypingANumber = false
    @IBOutlet weak var history: UILabel!
    @IBOutlet weak var display: UILabel!
    @IBAction func clearAll()
    {
        history.text = ""
        displayValue = 0
        brain = CalculatorBrain()
    }
    @IBAction func appendCharacter(sender: UIButton) {
        //for constant button oe variables
        let character = sender.currentTitle!
        if userIsTheMiddleOfTypingANumber { enter() }
        history.text = history.text! + character + "\n"
        if let result = brain.pushCharacter(character) {
            displayValue = result
        }else{
            displayValue = 0
        }
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
    
    @IBAction func dropLastdigit(){
        if userIsTheMiddleOfTypingANumber{
            if display.text!.characters.count > 1 {
                display.text = String(display.text!.characters.dropLast())
            }else{
                display.text = "0"
                userIsTheMiddleOfTypingANumber = false
            }
        }
    }
    
    @IBAction func changeSign(){
        if userIsTheMiddleOfTypingANumber{
            if display.text!.characters.contains("-"){
                display.text = String(display.text!.characters.dropFirst())
            }else{
                display.text!.insert("-", atIndex: display.text!.startIndex)
            }
        }
    }
    
    
    @IBAction func operate(sender: UIButton) {
        
        if userIsTheMiddleOfTypingANumber{
            enter()
        }
        if let operation = sender.currentTitle {
                history.text = history.text! + operation + " =\n"
            if let result = brain.performOperation(operation){
                displayValue = result
            }else{
                displayValue = nil
            }
        }
    }

    @IBAction func enter(){
        userIsTheMiddleOfTypingANumber = false
        //        operandStack.append(displayValue)
                history.text = history.text! + "\(displayValue!)\n"
        //        print("operandStack = \(operandStack)")
        if let result = brain.pushOperand(displayValue!) {
            displayValue = result
        }else{
            displayValue = nil
        }
    }
    var displayValue: Double?{
        get{
            if let result = NSNumberFormatter().numberFromString(display.text!){
            return result.doubleValue
            }else{
                return nil
            }
        }
        set{
            if newValue != nil{
            display.text = "\(newValue!)"
            }else{
                display.text = "wrong computed value!"
            }
            userIsTheMiddleOfTypingANumber = false
        }
    }
    
}

