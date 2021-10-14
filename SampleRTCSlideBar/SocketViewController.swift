//
//  ViewController.swift
//  SampleRTCSlideBar
//
//  Created by Fumiya Tanaka on 2019/02/21.
//  Copyright © 2019 Fumiya Tanaka. All rights reserved.
//

import UIKit
import SocketIO

enum EventName: String {
    case changeSlider
}

class SocketViewController: UIViewController {

    @IBOutlet var label: UILabel!
    @IBOutlet var slider: UISlider!
    
    let manager = SocketManager(
        socketURL: URL(string: "http://localhost:8080")!,
        config: [.log(true)]
    )
    var socket: SocketIOClient!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        socket = manager.defaultSocket
        
        socket.on(clientEvent: SocketClientEvent.connect) { (obj, emitter) in
            print("connect")
        }
        
        socket.on(EventName.changeSlider.rawValue) { [weak self] (obj, emitter) in
            let value = obj[0] as! Float
            self?.slider.setValue(value, animated: true)
            self?.label.text = String(value)
        }
        
        socket.connect()
    }
    
    @IBAction func sliderValueChaged(slider: UISlider) {
        socket.emit(EventName.changeSlider.rawValue, [slider.value])
    }
}

