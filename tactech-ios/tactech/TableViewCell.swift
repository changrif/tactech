//
//  TableViewCell.swift
//  Tactech
//
//  Created by Chandler Griffin on 11/3/19.
//  Copyright © 2019 Chandler Griffin. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCells(translation: [[Int]], labels: [[String]])   {
        if(translation != nil && translation.count > 0) {
            setState(translation: translation, labels: labels)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "brailleCell", for: indexPath as IndexPath) as! BrailleCell
        
        cell.clear()
        
        return cell
    }

    func setState(translation: [[Int]], labels: [[String]])   {
        var cells = collectionView.visibleCells as! [BrailleCell]
        for cell in cells   {
            cell.clear()
        }
        var counter = 0
        
        _ = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true){ t in
            cells[counter % 5].setState(cell: translation[counter], label: labels[counter])
            counter += 1

            if counter >= translation.count {
                t.invalidate()
            }
        }
    }

}
