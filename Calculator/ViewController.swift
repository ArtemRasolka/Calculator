//
//  ViewController.swift
//  Calculator
//
//  Created by Admin on 12.08.22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    var stillTyping = false
    var firstOperand: Double = 0
    var secondOperand: Double = 0
    var operationSing = ""
    var dotIsPlaced = false
    
    var currentInput: Double {
        get {
            return Double(label.text!)!
        }
        set {
            let value = "\(newValue)"
            let valueArray = value.components(separatedBy: ".")
            if valueArray[1] == "0" {
                label.text = "\(valueArray[0])"
            } else {
                label.text = "\(newValue)"
            }
            stillTyping = false
        }
    }
    
    @IBAction func actionNumberPressed(_ sender: UIButton) {
        let number = sender.titleLabel!.text!
        
        if stillTyping {
            label.text = label.text! + number
        } else {
            label.text = number
            stillTyping = true
        }
    }
    
    @IBAction func actionAC(_ sender: Any) {
        firstOperand = 0
        secondOperand = 0
        currentInput = 0
        label.text = "0"
        stillTyping = false
        dotIsPlaced = false
        operationSing = ""
    }
    
    @IBAction func actionPerCent(_ sender: Any) {
        if firstOperand == 0 {
            currentInput = currentInput / 100
        } else {
            secondOperand = firstOperand * currentInput /  100
        }
        stillTyping = false
    }
    
    func operateWithTwoOperands(operation: (Double, Double) -> Double) {
        currentInput = operation(firstOperand, secondOperand)
        stillTyping = false
    }
    
    @IBAction func actionEquals(_ sender: UIButton) {
        if stillTyping {
            secondOperand = currentInput
        }
        
        dotIsPlaced = false
        
        switch operationSing {
        case "+":
            operateWithTwoOperands{$0 + $1}
        case "-":
            operateWithTwoOperands{$0 - $1}
        case "✕":
            operateWithTwoOperands{$0 * $1}
        case "÷":
            operateWithTwoOperands{$0 / $1}
        default: break
        }
    }
    
    @IBAction func actionOperands(_ sender: UIButton) {
        operationSing = sender.titleLabel!.text!
        firstOperand = currentInput
        stillTyping = false
        dotIsPlaced = false
    }
    
    @IBAction func actionPlusMinus(_ sender: UIButton) {
        currentInput = -currentInput
    }
    
    @IBAction func actionDot(_ sender: UIButton) {
        if stillTyping && !dotIsPlaced {
            label.text = label.text!  + "."
            dotIsPlaced = true
        }
    }
}

