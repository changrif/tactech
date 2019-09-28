//
//  ViewController.swift
//  Tactech
//
//  Created by Chandler Griffin on 9/8/19.
//  Copyright © 2019 Chandler Griffin. All rights reserved.
//

import UIKit

extension Bool {
    init<T: BinaryInteger>(_ num: T) {
        self.init(num != 0)
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var inputBox: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    @IBOutlet weak var labelA: UILabel!
    @IBOutlet weak var A1: UIView!
    @IBOutlet weak var A2: UIView!
    @IBOutlet weak var A3: UIView!
    @IBOutlet weak var A4: UIView!
    @IBOutlet weak var A5: UIView!
    @IBOutlet weak var A6: UIView!
    
    @IBOutlet weak var labelB: UILabel!
    @IBOutlet weak var B1: UIView!
    @IBOutlet weak var B2: UIView!
    @IBOutlet weak var B3: UIView!
    @IBOutlet weak var B4: UIView!
    @IBOutlet weak var B5: UIView!
    @IBOutlet weak var B6: UIView!
    
    @IBOutlet weak var labelC: UILabel!
    @IBOutlet weak var C1: UIView!
    @IBOutlet weak var C2: UIView!
    @IBOutlet weak var C3: UIView!
    @IBOutlet weak var C4: UIView!
    @IBOutlet weak var C5: UIView!
    @IBOutlet weak var C6: UIView!
    
    @IBOutlet weak var labelD: UILabel!
    @IBOutlet weak var D1: UIView!
    @IBOutlet weak var D2: UIView!
    @IBOutlet weak var D3: UIView!
    @IBOutlet weak var D4: UIView!
    @IBOutlet weak var D5: UIView!
    @IBOutlet weak var D6: UIView!
    
    @IBOutlet weak var labelE: UILabel!
    @IBOutlet weak var E1: UIView!
    @IBOutlet weak var E2: UIView!
    @IBOutlet weak var E3: UIView!
    @IBOutlet weak var E4: UIView!
    @IBOutlet weak var E5: UIView!
    @IBOutlet weak var E6: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.sendButton.layer.cornerRadius = self.sendButton.frame.height / 6
        self.labelA.text = ""
        self.labelB.text = ""
        self.labelC.text = ""
        self.labelD.text = ""
        self.labelE.text = ""
        
        self.A1.layer.cornerRadius = self.A1.frame.height / 2
        self.A2.layer.cornerRadius = self.A2.frame.height / 2
        self.A3.layer.cornerRadius = self.A3.frame.height / 2
        self.A4.layer.cornerRadius = self.A4.frame.height / 2
        self.A5.layer.cornerRadius = self.A5.frame.height / 2
        self.A6.layer.cornerRadius = self.A6.frame.height / 2
        
        self.B1.layer.cornerRadius = self.B1.frame.height / 2
        self.B2.layer.cornerRadius = self.B2.frame.height / 2
        self.B3.layer.cornerRadius = self.B3.frame.height / 2
        self.B4.layer.cornerRadius = self.B4.frame.height / 2
        self.B5.layer.cornerRadius = self.B5.frame.height / 2
        self.B6.layer.cornerRadius = self.B6.frame.height / 2
        
        self.C1.layer.cornerRadius = self.C1.frame.height / 2
        self.C2.layer.cornerRadius = self.C2.frame.height / 2
        self.C3.layer.cornerRadius = self.C3.frame.height / 2
        self.C4.layer.cornerRadius = self.C4.frame.height / 2
        self.C5.layer.cornerRadius = self.C5.frame.height / 2
        self.C6.layer.cornerRadius = self.C6.frame.height / 2
        
        self.D1.layer.cornerRadius = self.D1.frame.height / 2
        self.D2.layer.cornerRadius = self.D2.frame.height / 2
        self.D3.layer.cornerRadius = self.D3.frame.height / 2
        self.D4.layer.cornerRadius = self.D4.frame.height / 2
        self.D5.layer.cornerRadius = self.D5.frame.height / 2
        self.D6.layer.cornerRadius = self.D6.frame.height / 2
        
        self.E1.layer.cornerRadius = self.E1.frame.height / 2
        self.E2.layer.cornerRadius = self.E2.frame.height / 2
        self.E3.layer.cornerRadius = self.E3.frame.height / 2
        self.E4.layer.cornerRadius = self.E4.frame.height / 2
        self.E5.layer.cornerRadius = self.E5.frame.height / 2
        self.E6.layer.cornerRadius = self.E6.frame.height / 2
    }
    
    @IBAction func process(_ sender: Any) {
        clear()
        send(message: transcribe(text: inputBox.text!))
    }
    
    func send(message: [[Int]]) {
        // send to gui
        var counter = 0
        let text = Array(inputBox.text!)
        
        _ = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true){ t in
            if(counter % 5 == 0) {
                self.labelA.text = String(text[counter])
                self.A1.backgroundColor = Bool(message[counter][0]) ? UIColor.black : UIColor.white
                self.A2.backgroundColor = Bool(message[counter][1]) ? UIColor.black : UIColor.white
                self.A3.backgroundColor = Bool(message[counter][2]) ? UIColor.black : UIColor.white
                self.A4.backgroundColor = Bool(message[counter][3]) ? UIColor.black : UIColor.white
                self.A5.backgroundColor = Bool(message[counter][4]) ? UIColor.black : UIColor.white
                self.A6.backgroundColor = Bool(message[counter][5]) ? UIColor.black : UIColor.white
            } else if(counter % 5 == 1) {
                self.labelB.text = String(text[counter])
                self.B1.backgroundColor = Bool(message[counter][0]) ? UIColor.black : UIColor.white
                self.B2.backgroundColor = Bool(message[counter][1]) ? UIColor.black : UIColor.white
                self.B3.backgroundColor = Bool(message[counter][2]) ? UIColor.black : UIColor.white
                self.B4.backgroundColor = Bool(message[counter][3]) ? UIColor.black : UIColor.white
                self.B5.backgroundColor = Bool(message[counter][4]) ? UIColor.black : UIColor.white
                self.B6.backgroundColor = Bool(message[counter][5]) ? UIColor.black : UIColor.white
            } else if(counter % 5 == 2)  {
                self.labelC.text = String(text[counter])
                self.C1.backgroundColor = Bool(message[counter][0]) ? UIColor.black : UIColor.white
                self.C2.backgroundColor = Bool(message[counter][1]) ? UIColor.black : UIColor.white
                self.C3.backgroundColor = Bool(message[counter][2]) ? UIColor.black : UIColor.white
                self.C4.backgroundColor = Bool(message[counter][3]) ? UIColor.black : UIColor.white
                self.C5.backgroundColor = Bool(message[counter][4]) ? UIColor.black : UIColor.white
                self.C6.backgroundColor = Bool(message[counter][5]) ? UIColor.black : UIColor.white
            } else if(counter % 5 == 3)  {
                self.labelD.text = String(text[counter])
                self.D1.backgroundColor = Bool(message[counter][0]) ? UIColor.black : UIColor.white
                self.D2.backgroundColor = Bool(message[counter][1]) ? UIColor.black : UIColor.white
                self.D3.backgroundColor = Bool(message[counter][2]) ? UIColor.black : UIColor.white
                self.D4.backgroundColor = Bool(message[counter][3]) ? UIColor.black : UIColor.white
                self.D5.backgroundColor = Bool(message[counter][4]) ? UIColor.black : UIColor.white
                self.D6.backgroundColor = Bool(message[counter][5]) ? UIColor.black : UIColor.white
            } else if(counter % 5 == 4)  {
                self.labelE.text = String(text[counter])
                self.E1.backgroundColor = Bool(message[counter][0]) ? UIColor.black : UIColor.white
                self.E2.backgroundColor = Bool(message[counter][1]) ? UIColor.black : UIColor.white
                self.E3.backgroundColor = Bool(message[counter][2]) ? UIColor.black : UIColor.white
                self.E4.backgroundColor = Bool(message[counter][3]) ? UIColor.black : UIColor.white
                self.E5.backgroundColor = Bool(message[counter][4]) ? UIColor.black : UIColor.white
                self.E6.backgroundColor = Bool(message[counter][5]) ? UIColor.black : UIColor.white
            }
            counter += 1
            
            if counter >= message.count {
                t.invalidate()
            }
        }
        
        // send to hardware?
    }
    
    func clear()    {
        self.labelA.text = String("")
        self.A1.backgroundColor = UIColor.white
        self.A2.backgroundColor = UIColor.white
        self.A3.backgroundColor = UIColor.white
        self.A4.backgroundColor = UIColor.white
        self.A5.backgroundColor = UIColor.white
        self.A6.backgroundColor = UIColor.white
        
        self.labelB.text = String("")
        self.B1.backgroundColor = UIColor.white
        self.B2.backgroundColor = UIColor.white
        self.B3.backgroundColor = UIColor.white
        self.B4.backgroundColor = UIColor.white
        self.B5.backgroundColor = UIColor.white
        self.B6.backgroundColor = UIColor.white
        
        self.labelC.text = String("")
        self.C1.backgroundColor = UIColor.white
        self.C2.backgroundColor = UIColor.white
        self.C3.backgroundColor = UIColor.white
        self.C4.backgroundColor = UIColor.white
        self.C5.backgroundColor = UIColor.white
        self.C6.backgroundColor = UIColor.white
        
        self.labelD.text = String("")
        self.D1.backgroundColor = UIColor.white
        self.D2.backgroundColor = UIColor.white
        self.D3.backgroundColor = UIColor.white
        self.D4.backgroundColor = UIColor.white
        self.D5.backgroundColor = UIColor.white
        self.D6.backgroundColor = UIColor.white
        
        self.labelE.text = String("")
        self.E1.backgroundColor = UIColor.white
        self.E2.backgroundColor = UIColor.white
        self.E3.backgroundColor = UIColor.white
        self.E4.backgroundColor = UIColor.white
        self.E5.backgroundColor = UIColor.white
        self.E6.backgroundColor = UIColor.white
    }
    
    func transcribe(text: String) -> [[Int]]   {
        var translation = [[Int]]()
        
        for char in Array(text)   {
            translation.append(translate(text: String(char)))
        }
        
        print(translation)
        return translation
    }
    
    func translate(text: String) -> [Int]    {
        return alphabet[text]!
    }

    let alphabet = [
        "a": [1, 0, 0, 0, 0, 0],
        "b": [1, 1, 0, 0, 0, 0],
        "c": [1, 0, 0, 1, 0, 0],
        "d": [1, 0, 0, 1, 1, 0],
        "e": [1, 0, 0, 0, 1, 0],
        "f": [1, 1, 0, 1, 0, 0],
        "g": [1, 1, 0, 1, 1, 0],
        "h": [1, 1, 0, 0, 1, 0],
        "i": [0, 1, 0, 1, 0, 0],
        "j": [0, 1, 0, 1, 1, 0],
        "k": [1, 0, 1, 0, 0, 0],
        "l": [1, 1, 1, 0, 0, 0],
        "m": [1, 0, 1, 1, 0, 0],
        "n": [1, 0, 1, 1, 1, 0],
        "o": [1, 0, 1, 0, 1, 0],
        "p": [1, 1, 1, 1, 0, 0],
        "q": [1, 1, 1, 1, 1, 0],
        "r": [1, 1, 1, 0, 1, 0],
        "s": [0, 1, 1, 1, 0, 0],
        "t": [0, 1, 1, 1, 1, 0],
        "u": [1, 0, 1, 0, 0, 1],
        "v": [1, 1, 1, 0, 0, 1],
        "w": [0, 1, 0, 1, 1, 1],
        "x": [1, 0, 1, 1, 0, 1],
        "y": [1, 0, 1, 1, 1, 1],
        "z": [1, 0, 1, 0, 1, 1]
    ]
}

