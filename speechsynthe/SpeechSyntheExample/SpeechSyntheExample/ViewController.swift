//
//  ViewController.swift
//  SpeechSyntheExample
//
//  Created by hironand on 2017/01/26.
//  Copyright © 2017年 appirca. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var word: UITextField!
    var speech: Speech?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        word.text = "こんにちは"
        self.speech = Speech()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    @IBAction func onSpeak(_ sender: Any) {
        speech?.speek(word: word.text)
    }

}

