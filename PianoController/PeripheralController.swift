//
//  PeripheralController
//  Bluetooth Controller
//
//  Created by Brandon Howard on 4/19/16.
//  Copyright (c) 2016 Ticklin' The Ivories. All rights reserved.
//  Reference : https://github.com/0x7fffffff/Core-Bluetooth-Transfer-Demo/tree/master/Bluetooth

import UIKit
import CoreBluetooth

class PeripheralController: UIViewController, CBPeripheralManagerDelegate, UITextViewDelegate {

	@IBOutlet weak var playButtonOutlet: UIButton!
    private var peripheralManager: CBPeripheralManager?
    private var transferCharacteristic: CBMutableCharacteristic?
    private var dataToSend: NSData?
    private var sendDataIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
    }

    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        peripheralManager?.stopAdvertising()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func peripheralManagerDidUpdateState(peripheral: CBPeripheralManager) {
        if (peripheral.state != CBPeripheralManagerState.PoweredOn) {
            return
        }

        print("PeripheralManager Powered ON")

        transferCharacteristic = CBMutableCharacteristic(type: transferCharacteristicUUID, properties: CBCharacteristicProperties.Notify, value: nil, permissions: CBAttributePermissions.Readable)

        let transferService = CBMutableService(type: transferServiceUUID, primary: true)

        transferService.characteristics = [transferCharacteristic!]
        peripheralManager!.addService(transferService)
    }

    func peripheralManager(peripheral: CBPeripheralManager, central: CBCentral, didSubscribeToCharacteristic characteristic: CBCharacteristic) {
        print("Central subscribed to characteristic")
    }

    func peripheralManager(peripheral: CBPeripheralManager, central: CBCentral, didUnsubscribeFromCharacteristic characteristic: CBCharacteristic) {
        print("Central unsubscribed from characteristic")
    }

    func peripheralManagerIsReadyToUpdateSubscribers(peripheral: CBPeripheralManager) {

    }

    func peripheralManagerDidStartAdvertising(peripheral: CBPeripheralManager, error: NSError?) {
        print(error)
    }

	func sendData(data: String) {
		dataToSend = data.dataUsingEncoding(NSUTF8StringEncoding)
		let amountToSend = dataToSend!.length
		let chunk = NSData(bytes: dataToSend!.bytes, length: amountToSend)
		peripheralManager!.updateValue(chunk, forCharacteristic: transferCharacteristic!, onSubscribedCentrals: nil)
	}

	@IBAction func startAdvertising() {
		peripheralManager!.startAdvertising([CBAdvertisementDataServiceUUIDsKey : [transferServiceUUID]])
		playButtonOutlet.hidden = true
	}

	@IBAction func sendC0(sender: AnyObject) {
		sendData("C0")
	}

	@IBAction func sendD(sender: AnyObject) {
		sendData("D")
	}

	@IBAction func sendE(sender: AnyObject) {
		sendData("E")
	}

	@IBAction func sendF(sender: AnyObject) {
		sendData("F")
	}

	@IBAction func sendG(sender: AnyObject) {
		sendData("G")
	}

	@IBAction func sendA(sender: AnyObject) {
		sendData("A")
	}

	@IBAction func sendB(sender: AnyObject) {
		sendData("B")
	}

	@IBAction func sendC1(sender: AnyObject) {
		sendData("C1")
	}
}