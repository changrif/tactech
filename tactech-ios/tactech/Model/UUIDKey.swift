//
//  UUIDKey.swift
//  Tactech
//
//  Created by Chandler Griffin on 11/5/19.
//  Copyright © 2019 Chandler Griffin. All rights reserved.
//

import CoreBluetooth

let kBLEService_UUID = "6e400001-b5a3-f393-e0a9-e50e24dcca9e"
let kBLE_Characteristic_uuid_Tx = "6e400002-b5a3-f393-e0a9-e50e24dcca9e"
let kBLE_Characteristic_uuid_Rx = "6e400003-b5a3-f393-e0a9-e50e24dcca9e"
let MaxCharacters = 20

let BLEService_UUID = CBUUID(string: kBLEService_UUID)
let BLE_Characteristic_uuid_Tx = CBUUID(string: kBLE_Characteristic_uuid_Tx)
let BLE_Characteristic_uuid_Rx = CBUUID(string: kBLE_Characteristic_uuid_Rx)
