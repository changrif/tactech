//
//  BrailleEncoder.swift
//  Tactech
//
//  Created by Chandler Griffin on 11/21/19.
//  Copyright © 2019 Chandler Griffin. All rights reserved.
//

import Foundation

enum TranslationMode { case number; case letter }

class BrailleEncoder {
    
    private var translation = [Braille]()
    private var mode: TranslationMode = .letter
    private var expectNumber = false
        
    func translate(toBraille text: String) -> [Braille]   {
        for char in text   {
            if expectNumber && char.type != .number   {
                replaceDecimalWithPeriod()
            }
            
            translate(char)
        }
        if expectNumber {
            replaceDecimalWithPeriod()
        }
        
        return translation
    }
    
    private func translate(_ char: Character)   {
        expectNumber = char == "."
        var type = char.type
        if !char.equals(mode: mode)   {
            addPrefix(of: type)
            switchMode(to: type)
        }
        
        if expectNumber {
            switch mode {
                case .number:
                    type = .number
                default:
                    type = .lowercase_letter
            }
        }
        
        switch type {
            case .capital_letter:
                translation.append(.capitalSign)
                fallthrough
            case .lowercase_letter:
                translation.append(Braille.letter[String(char)]!)
            case .number:
                translation.append(Braille.number[String(char)]!)
            default:
                if let braille = Braille.specialCharacters[String(char)]    {
                    for cell in braille    {
                        translation.append(cell)
                    }
                } else  {
                    translation.append(.unknown(char: char))
                }
        }
    }
    
    private func addPrefix(of type: CharacterType)    {
        switch type {
            case .number:
                translation.append(.numberSign)
            default:
                translation.append(.letterSign)
        }
    }
    
    private func switchMode(to type: CharacterType)    {
        switch type {
            case .number:
                mode = .number
            default:
                mode = .letter
        }
    }
    
    private func replaceDecimalWithPeriod()   {
        translation.removeLast()
        translation.append(Braille.letter["."]!)
    }
}

// MARK: Integer Boolean Conversion

extension Bool {
    init<T: BinaryInteger>(_ num: T) {
        self.init(num != 0)
    }
}

// MARK: Character ASCII Value

extension Character {
    var ascii: UInt32? {
        return String(self).unicodeScalars.filter{$0.isASCII}.first?.value
    }
    
    var type: CharacterType {
        let asciiVal = Int(self.ascii!)
        if asciiVal >= 65 && asciiVal <= 90    {
            return CharacterType.capital_letter
        }
        else if asciiVal >= 97 && asciiVal <= 122   {
            return CharacterType.lowercase_letter
        }
        else if asciiVal >= 48 && asciiVal <= 57   {
            return CharacterType.number
        }
        else    {
            return CharacterType.other
        }
    }
    
    func equals(mode: TranslationMode) -> Bool   {
        switch self.type    {
            case .other:
                return true
            case .number:
                return mode == .number
            default:
                return mode == .letter
        }
    }
}
