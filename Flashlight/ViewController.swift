//
//  ViewController.swift
//  Flashlight
//
//  Created by Wesley Austin on 8/17/16.
//  Copyright © 2016 Wesley Austin. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var toggleSwipeView: UIView! // View that conatians the UISwipeGestureRecognizer
    @IBOutlet weak var onOffLabel: UILabel!
    
    var device: AVCaptureDevice? = nil

   
    var isOn: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.sharedApplication().statusBarStyle = .LightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func toggleSwipeRecognizer(sender: UISwipeGestureRecognizer) {
        if sender.state == .Ended {
            
            //Obtains the media device that controls video
            let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
            
            // checks to see if the device has a flash
            if(device.hasTorch) {
                do  {
                    try device.lockForConfiguration()
                    if isOn {
                        // toggle flash
                        device.torchMode = AVCaptureTorchMode.Off
                        
                        // Change the direction of the swipe
                        sender.direction = .Right
                        
                        // Change view colors
                        toggleSwipeView.backgroundColor = .blackColor()
                        self.view.backgroundColor = .blackColor()
                        onOffLabel.textColor = .whiteColor()
                        
                        // Change text
                        onOffLabel.text = "On"
                        
                        // Change boolean marker
                        isOn = false
                    } else {
                        
                        do {
                            try device.setTorchModeOnWithLevel(1.0)
                        } catch {
                            print("\(error)")
                        }
                        // toggle flash
                        device.torchMode = AVCaptureTorchMode.On
                        
                        // Change the direction of the swipe
                        sender.direction = .Left
                        
                        // Change view colors
                        toggleSwipeView.backgroundColor = .whiteColor()
                        self.view.backgroundColor = .whiteColor()
                        onOffLabel.textColor = .blackColor()
                        
                        // Change text
                        onOffLabel.text = "Off"
                        
                        // Change boolean marker
                        isOn = true
                    }
                    toggleStatusBarStyle()
                } catch {
                    print("\(error)")
                }
                
          
            }
        }
    }
    

    func toggleStatusBarStyle() {
        if isOn {
            UIApplication.sharedApplication().statusBarStyle = .Default
        } else {
            UIApplication.sharedApplication().statusBarStyle = .LightContent
        }
    }
        
}



