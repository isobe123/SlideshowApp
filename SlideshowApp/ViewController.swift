//
//  ViewController.swift
//  SlideshowApp
//
//  Created by be on 2019/06/13.
//  Copyright © 2019年 isobe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let image = UIImage(named:"penguin.jpg")
        imageView.image = image
    }
    
    var timer:Timer!
    var timer_sec:Float = 0
    var dispImageNo = 0
    
    @IBOutlet weak var imageView: UIImageView!
    
    @objc func updateTimer(_ timer:Timer){
        self.timer_sec += 2.0
        dispImageNo += 1
        displayImage()
    }
    
    func displayImage(){
        let imageNameArray = ["penguin.jpg","antarctica.jpg","penguin2.jpg"]
        let lastIndex = imageNameArray.count - 1
        
        if dispImageNo < 0{
            dispImageNo = lastIndex
        }
        if dispImageNo > lastIndex{
            dispImageNo = 0
        }
        let name = imageNameArray[dispImageNo]
        let image = UIImage(named: name)
        imageView.image = image
    }

    @IBAction func start(_ sender: UIButton) {
       
        if self.timer == nil{
            self.timer = Timer.scheduledTimer(timeInterval:2.0, target:self, selector:#selector(updateTimer(_:)), userInfo:nil, repeats:true)
            sender.setTitle("停止", for:.normal)
            for button in invaldate{
              button.isEnabled = false
            }
        }else{
            self.timer.invalidate()
            self.timer_sec = 0
            self.timer = nil
            sender.setTitle("再生", for:.normal)
            for button in invaldate{
              button.isEnabled = true
            }
        }
    }
   
    @IBOutlet var invaldate: [UIButton]!
    
    @IBAction func `return`(_ sender: UIButton) {
        dispImageNo -= 1
        displayImage()
    }
    @IBAction func next(_ sender: UIButton) {
        dispImageNo += 1
        displayImage()
    }
    @IBOutlet weak var start: UIButton!
    
    @IBAction func onTapImage(_ sender: Any) {
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let resultViewController:ResultViewController = segue.destination as! ResultViewController
        resultViewController.image = self.imageView.image
        if self.timer != nil{
            self.timer.invalidate()
            self.timer_sec = 0
            self.timer = nil
            start.setTitle("再生", for:.normal)
        }
    }
    @IBAction func unwind(_ segue:UIStoryboardSegue){
        for button in invaldate{
            button.isEnabled = true
        }
    }
}

