//
//  ViewController.swift
//  SampleRTCSlideBar
//
//  Created by Fumiya Tanaka on 2019/02/21.
//  Copyright © 2019 Fumiya Tanaka. All rights reserved.
//

import UIKit
import SocketIO

class SocketViewController: UIViewController {

    @IBOutlet var labelStackView: UIStackView!
    @IBOutlet var label: UILabel!
    @IBOutlet var slider: UISlider!
    
    let manager = SocketManager(
        socketURL: URL(string: "http://localhost:3000")!,
        config: [.log(true), .compress, .forceNew(true)]
    )
    var socket: SocketIOClient!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        socket = manager.defaultSocket
        
        socket.on(clientEvent: .connect) { (obj, emitter) in
            print("connect")
        }
        
        socket.on("sliderValue") { [weak self] (obj, emitter) in
            print("sliderValue detected")
            print(obj)
            
            let value = obj[0] as! Float
            self?.slider.setValue(value, animated: true)
            self?.label.text = String(value)
        }
        
        socket.on(clientEvent: .statusChange) { data, ack in
            print(data)
            print(ack)
        }
        
        socket.connect()
    }
    
    @IBAction func sliderValueChaged(slider: UISlider) {
        socket.emit("sliderValue", [0])
    }
}

