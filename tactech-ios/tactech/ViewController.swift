//
//  ViewController.swift
//  Tactech
//
//  Created by Chandler Griffin on 9/8/19.
//  Copyright © 2019 Chandler Griffin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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

    func transcribe(text: String) -> [[Int]]   {
        var translation = [[Int]]()
        
        for char in Array(text)   {
            translation.append(translate(text: String(char)));
        }
        
        print(translation);
        return translation
    }
    
    func translate(text: String) -> [Int]    {
        return alphabet[text]!
    }

}

