//
//  BlueToothViewController.swift
//  apollo
//
//  Created by Sear Ahmad on 14/03/23.
//

import UIKit
import SnapKit
import CoreBluetooth
import Combine

class BlueToothViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties
    private var availableDevices: [CBPeripheral] = []
    private var bluetoothManager: BluetoothManager!
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - UI
    private lazy var blueToothIconImageView: UIImageView = {
        let image = UIImage(named: "bluetooth.icon")
        let imageView = UIImageView(image: image)
        imageView.tintColor = .systemBlue
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "READY TO SEARCH"
        label.textColor = .white
        label.font = .systemFont(ofSize: 28, weight: .bold)
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Remember to keep your scooter to on and within 6 feet"
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    private lazy var devicesTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .black
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BluetoothDeviceTableViewCell.self, forCellReuseIdentifier: BluetoothDeviceTableViewCell.nameOfClass)
        tableView.separatorColor = .gray
        return tableView
    }()
    
    private lazy var scanButton = ApolloPrimaryButton(title: "Scan") { [weak self] in
        (self?.bluetoothManager.isScanning)! ? self?.stopScanning() : self?.startScanning()
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bluetoothManager = BluetoothManager(centralManager: CBCentralManager())
        setupUI()
        makeConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkBluetoothState()
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        
        view.addSubview(blueToothIconImageView)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(devicesTableView)
        view.addSubview(scanButton)
    }
    
    // MARK: - Constraints
    private func makeConstraints() {
        let screenHeight = UIScreen.main.bounds.height
        
        blueToothIconImageView.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.top.equalToSuperview().inset(screenHeight / 5)
            make.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(blueToothIconImageView.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        devicesTableView.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(100)
        }
        
        scanButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(36)
            make.centerX.equalToSuperview()
            make.width.greaterThanOrEqualTo(100)
        }
    }
    
    // MARK: - UITableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return availableDevices.count
    }
    
    // MARK: - UITableView DataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BluetoothDeviceTableViewCell.nameOfClass, for: indexPath) as! BluetoothDeviceTableViewCell
        cell.deviceTitle = availableDevices[indexPath.row].name ?? "\(availableDevices[indexPath.row].identifier)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Scooters Found:"
    }
    
    // MARK: - Animations
    private func startBlutoothAnimating() {
        UIView.animate(withDuration: 0.5, delay: 0, options: [.repeat, .autoreverse], animations: {
            self.blueToothIconImageView.alpha = 0.2
        }, completion: nil)
    }
    
    private func stopBluetoothAnimating() {
        UIView.animate(withDuration: 0, animations: {
            self.blueToothIconImageView.alpha = 1
        })
    }
}

extension BlueToothViewController {
    // MARK: - Bluetooth
    private func didDiscoverPeripheralPublisher() {
        bluetoothManager.discoveredPeripheralPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { error in
                self.showError(error: error)
                
            }, receiveValue: { peripheral in
                if !self.availableDevices.contains(peripheral) {
                    self.availableDevices.insert(peripheral, at: 0)
                    self.devicesTableView.reloadData()
                }
            })
            .store(in: &cancellables)
    }
    
    private func checkBluetoothState() {
        bluetoothManager.centralStatePublisher
            .receive(on: DispatchQueue.main)
            .sink { state in
                switch state {
                case .poweredOn:
                    self.devicesTableView.isHidden = false
                    self.availableDevices = []

                case .poweredOff:
                    self.devicesTableView.isHidden = true
                    self.showAlert(title: "Bluetooth is off", message: "Please turn on Bluetooth in Settings", actionTitle: "Go to Settings")
                    self.stopBluetoothAnimating()
                default:
                    break
                }
            }
            .store(in: &cancellables)
    }
    
    private func startScanning() {
        bluetoothManager.startScanning()
        didDiscoverPeripheralPublisher()
        self.titleLabel.text = "SEARCHING"
        self.scanButton.setTitle("Stop", for: .normal)
        startBlutoothAnimating()
    }
    
    private func stopScanning() {
        bluetoothManager.stopScanning()
        if availableDevices.isEmpty {
            self.titleLabel.text = "NO SCOOTERS FOUND"
        } else {
            self.titleLabel.text = "READY TO SEARCH"
        }
        self.scanButton.setTitle("Scan", for: .normal)
        stopBluetoothAnimating()
    }
    
    // MARK: - Alerts
    private func showAlert(title: String, message: String, actionTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .default) { (action) in
            let url = URL(string: "App-Prefs:root=Bluetooth")
            if UIApplication.shared.canOpenURL(url!) {
                UIApplication.shared.open(url!, options: [:], completionHandler: nil)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(action)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func showError(error: Subscribers.Completion<Error>) {
        let errorAlert = UIAlertController(title: "Error", message: "Something went wrong. \(error)", preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        errorAlert.addAction(dismissAction)
        present(errorAlert, animated: true, completion: nil)
    }
}
