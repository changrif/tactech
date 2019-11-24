//
//  TableViewCell.swift
//  Tactech
//
//  Created by Chandler Griffin on 11/3/19.
//  Copyright © 2019 Chandler Griffin. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    func setCells(translation: [Braille])   {
        if(translation.count > 0) {
            setState(translation: translation)
        }
    }

    func setState(translation: [Braille])   {
        let cells = collectionView.visibleCells as! [BrailleCell]
        for cell in cells   {
            cell.clear()
        }
        var counter = 0
        
        _ = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true){ t in
            cells[counter % 5].setState(cell: translation[counter])
            counter += 1

            if counter >= translation.count {
                t.invalidate()
            }
        }
    }

}

// MARK: UICollectionView Delegates

extension TableViewCell: UICollectionViewDelegate, UICollectionViewDataSource   {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "brailleCell", for: indexPath as IndexPath) as! BrailleCell
        
        cell.clear()
        
        return cell
    }
}
