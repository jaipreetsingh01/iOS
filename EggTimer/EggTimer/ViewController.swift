//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
var timer = Timer()
var start = 0
var maxCount = 0

let eggTimers = ["Soft": 5 , "Medium":7 , "Hard": 12]

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!

    @IBAction func buttonPress(_ sender: UIButton)
    {
        timer.invalidate()
        start = 0
        maxCount = 0
        
        titleLabel.text = sender.currentTitle! + " in progress"
        
        
//      print(eggTimers[sender.currentTitle!]!)
        progressBar.progress = 0
        maxCount =  eggTimers[sender.currentTitle!]!
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runTimer), userInfo: nil, repeats: true)
    }
    
    
        @objc func runTimer(){
            start = start + 1
            progressBar.progress = Float(start) / Float(maxCount)
            
            
            if start > maxCount {
                titleLabel.text = "Done"
                timer.invalidate()}
    }

}
