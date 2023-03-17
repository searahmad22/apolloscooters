//
//  BluetoothManager.swift
//  apollo
//
//  Created by Sear Ahmad on 17/03/23.
//

import Foundation
import Combine
import CoreBluetooth

class BluetoothManager: NSObject {
    
    private let centralManager: CBCentralManager
    private var discoveredPeripheralSubject = PassthroughSubject<CBPeripheral, Error>()
    private var connectedPeripheralSubject = PassthroughSubject<CBPeripheral, Error>()
    private var centralStateSubject = PassthroughSubject<CBManagerState, Never>()
    @Published var isScanning = false
    
    var discoveredPeripheralPublisher: AnyPublisher<CBPeripheral, Error> {
        return discoveredPeripheralSubject.eraseToAnyPublisher()
    }
    
    var connectedPeripheralPublisher: AnyPublisher<CBPeripheral, Error> {
        return connectedPeripheralSubject.eraseToAnyPublisher()
    }
    
    var centralStatePublisher: AnyPublisher<CBManagerState, Never> {
        return centralStateSubject.eraseToAnyPublisher()
    }
    
    init(centralManager: CBCentralManager) {
        self.centralManager = centralManager
        super.init()
        self.centralManager.delegate = self
    }
    
    func startScanning(for services: [CBUUID]? = nil) {
        centralManager.scanForPeripherals(withServices: services, options: nil)
        isScanning = true
    }
    
    func stopScanning() {
        centralManager.stopScan()
        isScanning = false
    }
    
    func connect(to peripheral: CBPeripheral) {
        centralManager.connect(peripheral, options: nil)
    }
}

extension BluetoothManager: CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        centralStateSubject.send(central.state)
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        discoveredPeripheralSubject.send(peripheral)
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        connectedPeripheralSubject.send(peripheral)
    }
}
