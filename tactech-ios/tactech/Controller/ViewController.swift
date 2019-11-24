//
//  ViewController.swift
//  Tactech
//
//  Created by Beatrice Villanueva and Chandler Griffin on 9/8/19.
//  Copyright © 2019 Beatrice Villanueva and Chandler Griffin. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController  {

    @IBOutlet weak var inputBox: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    var braille: [Braille]?
    var peripheralManager: CBPeripheralManager?
    var peripheral: CBPeripheral!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sendButton.layer.cornerRadius = self.sendButton.frame.height / 6
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 215
        
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
    }
    
    @IBAction func process(_ sender: Any) {
        // Convert to Braille
        if let inputText = inputBox.text {
            let encoder = BrailleEncoder()
            braille = encoder.translate(toBraille: inputText)
            
            tableView.reloadData()
            
            send(braille!)
        }
    }
    
    func send(_ data: [Braille]){
        var counter = 0
        _ = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true){ t in
            let valueString = (data[counter].description as NSString).data(using: String.Encoding.utf8.rawValue)

            if let blePeripheral = blePeripheral    {
                if let txCharacteristic = txCharacteristic  {
                    blePeripheral.writeValue(valueString!, for: txCharacteristic, type: CBCharacteristicWriteType.withResponse)
                }
            }
            counter += 1

            if counter >= data.count {
                t.invalidate()
            }
        }
    }
}

// MARK: CBPeripheralManagerDelegate

extension ViewController: CBPeripheralManagerDelegate   {
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        if peripheral.state == .poweredOn {
            return
        }
        print("Peripheral manager is running")
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, central: CBCentral, didSubscribeTo characteristic: CBCharacteristic) {
        print("Device subscribe to characteristic")
    }
    
    func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) {
        if let error = error {
            print("\(error)")
            return
        }
    }
}

// MARK: TableView Datasource

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "tableCell") as! TableViewCell
        
        if let cells = braille  {
            cell.setCells(translation: cells)
        }
        
        return cell
    }
}

// MARK: TableView Delegate

extension ViewController: UITableViewDelegate   {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 215
    }
}
