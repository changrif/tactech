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

extension Character {
    var ascii: UInt32? {
        return     String(self).unicodeScalars.filter{$0.isASCII}.first?.value
    }
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var translationMode = TranslationMode.letter

    @IBOutlet weak var inputBox: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    var cells: [[Int]] = []
    var labels: [[String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.sendButton.layer.cornerRadius = self.sendButton.frame.height / 6
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 215
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 215
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "tableCell") as! TableViewCell
        
        cell.setCells(translation: self.cells, labels: self.labels)
        
        return cell
    }
    
    @IBAction func process(_ sender: Any) {
        send(message: transcribe(text: inputBox.text!))
    }
    
    func send(message: ([[Int]], [[String]])) {
        // send to gui
        var counter = 0
        self.cells = message.0
        self.labels = message.1
        self.tableView.reloadData()
        
        // send to hardware?
    }
    
    func format(text: [[Int]]) -> String    {
        var formattedString = ""
        for cell in text    {
            formattedString += cell.map({ String(describing: $0) }).joined(separator: ",") + ";"
        }
        return formattedString
    }
    
    func transcribe(text: String) -> ([[Int]], [[String]])   {
        var translation = [[Int]]()
        var stringTranslation = [[String]]()
        
        for char in Array(text)   {
            let (temp, stringTemp, mode) = translate(char: char)
            if(translationMode == TranslationMode.decimal_point && mode != TranslationMode.number)  {
                translation.popLast()
                stringTranslation.popLast()
                translation.append([0, 1, 0, 0, 1, 1])
                stringTranslation.append(["."])
            }
            for arr in temp {
                translation.append(arr)
                translationMode = mode
            }
            
            for arr in stringTemp   {
                stringTranslation.append(arr)
            }
        }
        
        print(format(text: translation))
        return (translation, stringTranslation)
    }
    
    func getCharacterType(char: Character) -> CharacterType    {
        let asciiVal = Int(char.ascii!)
        if(asciiVal >= 65 && asciiVal <= 90)    {
            return CharacterType.capital_letter
        }
        else if(asciiVal >= 97 && asciiVal <= 122)   {
            return CharacterType.lowercase_letter
        }
        else if(asciiVal >= 48 && asciiVal <= 57)   {
            return CharacterType.number
        }
        else    {
            return CharacterType.other
        }
    }
    
    func translate(char: Character) -> ([[Int]], [[String]], TranslationMode)    {
        let charType = getCharacterType(char: char)
        if(charType == CharacterType.capital_letter)    {
            if(translationMode == TranslationMode.number)   {
                return ([signs["let"] as! Array<Int>, signs["cap"] as! Array<Int>, alphabet[String(char).lowercased()]!],
                    [["let"], ["cap"], [String(char).lowercased()]],
                    TranslationMode.letter)
            }
            
            return ([signs["cap"] as! Array<Int>, alphabet[String(char).lowercased()]!],
                [["cap"], [String(char).lowercased()]],
                TranslationMode.letter)
        }
        else if(charType == CharacterType.lowercase_letter)   {
            if(translationMode == TranslationMode.number)   {
                return ([signs["let"] as! Array<Int>, alphabet[String(char)]!],
                    [["let"], [String(char).lowercased()]],
                    TranslationMode.letter)
            }

            return ([alphabet[String(char)]!],
                    [[String(char).lowercased()]],
                    TranslationMode.letter)
        }
        else if(charType == CharacterType.number)   {
            if(translationMode == TranslationMode.letter)   {
                return ([signs["num"] as! Array<Int>, numbers[String(char)]!],
                    [["num"], [String(char)]],
                    TranslationMode.number)
            }

            return ([numbers[String(char)]!],
                    [[String(char)]],
                    TranslationMode.number)
        }
        
        if(translationMode == TranslationMode.number)   {
            return ([signs["decimal_point"] as! Array<Int>],
                [["decimal_point"], [String(char)]],
                TranslationMode.decimal_point)
        }
        
        if(specialCharacters[String(char)] != nil)  {
            return (specialCharacters[String(char)]!, [[String(char)]], translationMode)
        }
        
        return ([[1, 1, 1, 1, 1, 1]], [[String(char)]], translationMode)
    }
    
    enum CharacterType {
        case number
        case capital_letter
        case lowercase_letter
        case other
    }
    
    enum TranslationMode {
        case number
        case letter
        case decimal_point
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
    
    let numbers = [
        "1": [1, 0, 0, 0, 0, 0],
        "2": [1, 1, 0, 0, 0, 0],
        "3": [1, 0, 0, 1, 0, 0],
        "4": [1, 0, 0, 1, 1, 0],
        "5": [1, 0, 0, 0, 1, 0],
        "6": [1, 1, 0, 1, 0, 0],
        "7": [1, 1, 0, 1, 1, 0],
        "8": [1, 1, 0, 0, 1, 0],
        "9": [0, 1, 0, 1, 0, 0],
        "0": [0, 1, 0, 1, 1, 0]
    ]
    
    let specialCharacters = [
        ",": [[0, 1, 0, 0, 0, 0]],
        ";": [[0, 1, 1, 0, 0, 0]],
        ":": [[0, 1, 0, 0, 1, 0]],
        ".": [[0, 1, 0, 0, 1, 1]],
        "!": [[0, 1, 1, 0, 1, 0]],
        "(": [[0, 1, 1, 0, 1, 1]],
        ")": [[0, 1, 1, 0, 1, 1]],
        "?": [[0, 1, 1, 0, 0, 1]],
        "\"": [[0, 0, 0, 0, 0, 1], [0, 1, 1, 0, 1, 1]],
        "*": [[0, 0, 1, 0, 1, 0]],
        " ": [[0, 0, 0, 0, 0, 0]],
    ]

    let signs = [
        "let": [0, 0, 0, 0, 1, 1],
        "cap": [0, 0, 0, 0, 0, 1],
        "num": [0, 0, 1, 1, 1, 1],
        "decimal_point": [0, 0, 0, 1, 0, 1]
    ]
    
}

