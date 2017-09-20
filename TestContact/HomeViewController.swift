//
//  ViewController.swift
//  TestContact
//
//  Created by Andrew Phillips on 8/27/17.
//  Copyright © 2017 Andrew Phillips. All rights reserved.
//
import UIKit
import CoreBluetooth

var peripheralId: String!

class HomeViewController: UIViewController, CBCentralManagerDelegate,UITableViewDelegate, UITableViewDataSource {
    
    var manager: CBCentralManager!
    var peripherals = Array<CBPeripheral>()
    
    @IBOutlet weak var tableViewname: UITableView!
    
    @IBOutlet weak var settingsImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.imageTapped(gesture:)))
        
        // add it to the image view;
        settingsImage.addGestureRecognizer(tapGesture)
        // make sure imageView can be interacted with by user
        settingsImage.isUserInteractionEnabled = true
        
        manager = CBCentralManager(delegate: self, queue: nil)
        
        
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        var msg = ""
        switch (central.state) {
            
        case .poweredOff:
            msg = "Bluetooth switched off"
        case .poweredOn:
            msg = "Bluetooth switched on"
            manager.scanForPeripherals(withServices: nil, options:nil)
        case .unsupported:
            msg = "Bluetooth not available"
        default: break
        }
        print("State: \(msg)")
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        print("Discovered device: \(String(describing: peripheral.name))")
        
        if(peripherals.isEmpty && peripheral.name != nil){
            print("Array is empty adding device: \(String(describing: peripheral.name))")
            peripherals.append(peripheral)
        }
        else{
            if(peripheral.name != nil){
                var i = 1
                for perph in peripherals{
                    print("Itteration: \(String(describing: perph.name))")
                    if(peripheral == perph){
                        i = 0
                        print("Device: \(String(describing: perph.name)) already exisits")
                    }
                }
                if(i == 1){
                    print("Adding device: \(String(describing: peripheral.name))")
                    peripherals.append(peripheral)
                    self.tableViewname.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return test.count
        return peripherals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = peripherals[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(peripherals[indexPath.row].identifier.uuidString)
        
        //check if device is in DB
        
        peripheralId = peripherals[indexPath.row].identifier.uuidString
        if(!peripheralId.isEmpty){
            performSegue(withIdentifier: "ProfileSegue", sender: nil)
        }
    }
    
    @IBAction func signOutButton(_ sender: UIButton) {
        performSegue(withIdentifier: "HomeSegue", sender: nil)
    }
    
    @objc func imageTapped(gesture: UIGestureRecognizer) {
        // if the tapped view is a UIImageView then set it to imageview
        if (gesture.view as? UIImageView) != nil {
            print("Image Tapped")
            //Here you can initiate your new ViewController
            performSegue(withIdentifier: "EditProfileSegue", sender: nil)
        }
    }
}
