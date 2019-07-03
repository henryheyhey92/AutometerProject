//
//  ViewController.swift
//  GDmeter
//
//  Created by henrylai on 4/6/19.
//  Copyright © 2019 com.henrylai. All rights reserved.
//

import UIKit

class ViewController: UIViewController, URLSessionDelegate, URLSessionDataDelegate {
    var speed: GDGaugeView!
    var speedLabel: UILabel!
    var slider: UISlider!
    
    let interval:CGFloat = 1.0/24
    var acceleration:CGFloat = 15
    var count:CGFloat = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create and instatiate the view and set parameters
        speed = GDGaugeView(frame: view.bounds)
        //        speed.unitImage = #imageLiteral(resourceName: "fuel")
        //        speed.unitImageTint = UIColor(red: 0 / 255, green: 72 / 255, blue: 67 / 255, alpha: 1)
        // Set main gauge view color
        speed.baseColor = UIColor.cyan
        
        // Show circle border
        // -> speed.showBorder = false
        
        // Show full circle border if .showBorder is set to true
        // -> speed.fullBorder = true
        
        // Set starting degree based on zero degree on bottom center of circle space
        // -> speed.startDegree = 45.0
        
        // Set ending degree based on zero degree on bottom center of circle space
        // -> speed.endDegree = 270.0
        
        // Minimum value
        // -> speed.min = 0.0
        
        // Maximum value
        // -> speed.max = 16.0
        
        // Determine each step value
        // -> speed.stepValue = 4.0
        
        // Color of handle
        // -> speed.handleColor = UIColor.cyan
        
        // Color of seprators
        // -> speed.sepratorColor = UIColor.black
        
        // Color of texts
        // -> speed.textColor = UIColor.black
        
        // Center indicator text
        //speed.unitText = "mb/s"
        speed.unitText = "meter"
        
        // Center indicator font
        // -> speed.unitTextFont = UIFont.systemFont(ofSize: 10)
        
        // Indicators text
        // -> speed.textFont = UIFont.systemFont(ofSize: 20)
        view.addSubview(speed)
        
        /// After configuring the component, call setupView() method to create the gauge view
        speed.setupView()
        
        speedLabel = UILabel()
        speedLabel.font = UIFont.systemFont(ofSize: 17)
        speedLabel.textColor = UIColor.black
        speedLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(speedLabel)
        
        speedLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -45).isActive = true  //-45
        speedLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0.0).isActive = true
        
        slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 220  //220
        slider.isContinuous = true
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(valChange(_:)), for: .valueChanged)
        view.addSubview(slider)
        
        slider.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
        slider.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25).isActive = true
        slider.bottomAnchor.constraint(equalTo: speedLabel.topAnchor, constant: -35).isActive = true
        
      
        
        Timer.scheduledTimer(timeInterval: TimeInterval(interval), target: self, selector: #selector(fire), userInfo: nil, repeats: true)
        
//        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
//        button.backgroundColor = .blue
//        button.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0)
//        button.leftAnchor.constraint(equalToSystemSpacingAfter: view.leftAnchor, multiplier: 25)
//        button.rightAnchor.constraint(equalToSystemSpacingAfter: view.rightAnchor, multiplier: -25)
//        button.setTitle("Test Button", for: .normal)
//        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
//
//
//
//        self.view.addSubview(button)
        
        //        checkForSpeedTest()
    }
    
    @objc func fire(){
        
        count += interval * acceleration;
        if (count > 220) {
            count = 220;
            acceleration = -15;
        }
        if (count < 0) {
            count = 0;
            acceleration = 15;
        }
        
        // Set value for gauge view
        speed.currentValue = count
        
        if count > 30 && count <= 100.0 {
            speed.updateColors(with: UIColor.orange, unitsColor: UIColor.brown)
        }else if count > 101 && count <= 160.0 {
            speed.updateColors(with: UIColor.purple, unitsColor: UIColor.black)
        }else if count > 161.0 && count <= 220{
            speed.updateColors(with: UIColor.red, unitsColor: UIColor.cyan)
        }else{
            speed.resetColors()
        }
        
    }
    
    @IBAction func nextview(_ sender: Any) {
    }
    
//    @objc func buttonAction(sender: UIButton!) {
//        print("Button tapped")
//    }
    
    /// Moving handle using slider
    @objc func valChange(_ sender: UISlider){
        // Set .currentValue of GDGaugeView to move the handle
        
        print(sender.value)
        
      
        speed.currentValue = CGFloat(sender.value)
        
        if sender.value > 30 && sender.value <= 100.0 {
            speed.updateColors(with: UIColor.orange, unitsColor: UIColor.brown)
        }else if sender.value > 101 && sender.value <= 220.0 {
            speed.updateColors(with: UIColor.purple, unitsColor: UIColor.black)
        }else{
            speed.resetColors()
        }
    }
    
    //// Testing with download file. showing download speed
    var startTime: CFAbsoluteTime!
    var stopTime: CFAbsoluteTime!
    var bytesReceived: Int!
    
    
}
