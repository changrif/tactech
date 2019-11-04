//
//  BrailleCell.swift
//  Tactech
//
//  Created by Chandler Griffin on 11/3/19.
//  Copyright © 2019 Chandler Griffin. All rights reserved.
//

import UIKit

class BrailleCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var p1: UIView!
    @IBOutlet weak var p2: UIView!
    @IBOutlet weak var p3: UIView!
    @IBOutlet weak var p4: UIView!
    @IBOutlet weak var p5: UIView!
    @IBOutlet weak var p6: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.label.text = ""
        self.p1.layer.cornerRadius = self.p1.frame.height / 2
        self.p2.layer.cornerRadius = self.p2.frame.height / 2
        self.p3.layer.cornerRadius = self.p3.frame.height / 2
        self.p4.layer.cornerRadius = self.p4.frame.height / 2
        self.p5.layer.cornerRadius = self.p5.frame.height / 2
        self.p6.layer.cornerRadius = self.p6.frame.height / 2

        clear()
    }

    func getColor(val: Int) -> UIColor {
        return Bool(val) ? UIColor.black : UIColor.white
    }
    
    func setState(cell: [Int], label: [String]) {
        self.label.text = String(label[0])
        self.p1.backgroundColor = getColor(val: cell[0])
        self.p2.backgroundColor = getColor(val: cell[1])
        self.p3.backgroundColor = getColor(val: cell[2])
        self.p4.backgroundColor = getColor(val: cell[3])
        self.p5.backgroundColor = getColor(val: cell[4])
        self.p6.backgroundColor = getColor(val: cell[5])
    }
    
    func clear()    {
        self.label.text = String(" ")
        self.p1.backgroundColor = UIColor.white
        self.p2.backgroundColor = UIColor.white
        self.p3.backgroundColor = UIColor.white
        self.p4.backgroundColor = UIColor.white
        self.p5.backgroundColor = UIColor.white
        self.p6.backgroundColor = UIColor.white
    }
}
