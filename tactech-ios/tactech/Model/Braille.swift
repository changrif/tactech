//
//  Braille.swift
//  Tactech
//
//  Created by Chandler Griffin on 11/12/19.
//  Copyright © 2019 Chandler Griffin. All rights reserved.
//

import Foundation

enum CharacterType { case number; case capital_letter; case lowercase_letter; case other }

struct Braille  {
    let p1: Int
    let p2: Int
    let p3: Int
    let p4: Int
    let p5: Int
    let p6: Int
    
    let text: String
    
    init(_ p1: Int, _ p2: Int, _ p3: Int, _ p4: Int, _ p5: Int, _ p6: Int, text: String) {
        self.p1 = p1
        self.p2 = p2
        self.p3 = p3
        self.p4 = p4
        self.p5 = p5
        self.p6 = p6
        self.text = text
    }
    
    public var description: String {
        return "\(p1),\(p2),\(p3),\(p4),\(p5),\(p6);"
    }
    
    static func unknown(char: Character) -> Braille {
        return Braille(1, 1, 1, 1, 1, 1, text: String(char))
    }
    
    static var capitalSign: Braille {
        return Braille(0, 0, 0, 0, 0, 1, text: "Capital")
    }
    
    static var letterSign: Braille {
        return Braille(0, 0, 0, 0, 1, 1, text: "Letter")
    }
    
    static var numberSign: Braille {
        return Braille(0, 0, 1, 1, 1, 1, text: "Number")
    }
    
    static let letter = [
        "a": Braille(1, 0, 0, 0, 0, 0, text: "a"),
        "b": Braille(1, 1, 0, 0, 0, 0, text: "b"),
        "c": Braille(1, 0, 0, 1, 0, 0, text: "c"),
        "d": Braille(1, 0, 0, 1, 1, 0, text: "d"),
        "e": Braille(1, 0, 0, 0, 1, 0, text: "e"),
        "f": Braille(1, 1, 0, 1, 0, 0, text: "f"),
        "g": Braille(1, 1, 0, 1, 1, 0, text: "g"),
        "h": Braille(1, 1, 0, 0, 1, 0, text: "h"),
        "i": Braille(0, 1, 0, 1, 0, 0, text: "i"),
        "j": Braille(0, 1, 0, 1, 1, 0, text: "j"),
        "k": Braille(1, 0, 1, 0, 0, 0, text: "k"),
        "l": Braille(1, 1, 1, 0, 0, 0, text: "l"),
        "m": Braille(1, 0, 1, 1, 0, 0, text: "m"),
        "n": Braille(1, 0, 1, 1, 1, 0, text: "n"),
        "o": Braille(1, 0, 1, 0, 1, 0, text: "o"),
        "p": Braille(1, 1, 1, 1, 0, 0, text: "p"),
        "q": Braille(1, 1, 1, 1, 1, 0, text: "q"),
        "r": Braille(1, 1, 1, 0, 1, 0, text: "r"),
        "s": Braille(0, 1, 1, 1, 0, 0, text: "s"),
        "t": Braille(0, 1, 1, 1, 1, 0, text: "t"),
        "u": Braille(1, 0, 1, 0, 0, 1, text: "u"),
        "v": Braille(1, 1, 1, 0, 0, 1, text: "v"),
        "w": Braille(0, 1, 0, 1, 1, 1, text: "w"),
        "x": Braille(1, 0, 1, 1, 0, 1, text: "x"),
        "y": Braille(1, 0, 1, 1, 1, 1, text: "y"),
        "z": Braille(1, 0, 1, 0, 1, 1, text: "z"),
        ".": Braille(0, 1, 0, 0, 1, 1, text: ".")
    ]

    static let number = [
        "1": Braille(1, 0, 0, 0, 0, 0, text: "1"),
        "2": Braille(1, 1, 0, 0, 0, 0, text: "2"),
        "3": Braille(1, 0, 0, 1, 0, 0, text: "3"),
        "4": Braille(1, 0, 0, 1, 1, 0, text: "4"),
        "5": Braille(1, 0, 0, 0, 1, 0, text: "5"),
        "6": Braille(1, 1, 0, 1, 0, 0, text: "6"),
        "7": Braille(1, 1, 0, 1, 1, 0, text: "7"),
        "8": Braille(1, 1, 0, 0, 1, 0, text: "8"),
        "9": Braille(0, 1, 0, 1, 0, 0, text: "9"),
        "0": Braille(0, 1, 0, 1, 1, 0, text: "0"),
        ".": Braille(0, 0, 0, 1, 0, 1, text: ".")
    ]

    static let specialCharacters = [
        ",": [Braille(0, 1, 0, 0, 0, 0, text: ",")],
        ";": [Braille(0, 1, 1, 0, 0, 0, text: ";")],
        ":": [Braille(0, 1, 0, 0, 1, 0, text: ":")],
        "!": [Braille(0, 1, 1, 0, 1, 0, text: "!")],
        "(": [Braille(0, 1, 1, 0, 1, 1, text: "(")],
        ")": [Braille(0, 1, 1, 0, 1, 1, text: ")")],
        "?": [Braille(0, 1, 1, 0, 0, 1, text: "?")],
        "\"": [Braille(0, 0, 0, 0, 0, 1, text: "\""), Braille(0, 1, 1, 0, 1, 1, text: "")],
        "*": [Braille(0, 0, 1, 0, 1, 0, text: "*")],
        " ": [Braille(0, 0, 0, 0, 0, 0, text: " ")]
    ]
}
