//
//  ViewController.swift
//  CameraExample
//
//  Created by hironand on 2016/12/11.
//  Copyright © 2016年 hironand. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var shutterBtn: UIButton!
    @IBOutlet weak var previewImg: UIImageView!
    
    var shutterBtnOn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //------------------
    // Handle Event
    //------------------
    @IBAction func onTouchShutterBtn(_ sender: Any) {
        // self.playButton.setImage(UIImage(named: "play_on"), forState: UIControlState.Normal)
        if self.shutterBtnOn {
            self.shutterBtn.setImage(UIImage(named: "camera_btn"), for: UIControlState.normal)
            self.shutterBtnOn = false
        } else {
            self.shutterBtn.setImage(UIImage(named: "camera_btn_on"), for: UIControlState.normal)
            self.shutterBtnOn = true
        }
    }


}

