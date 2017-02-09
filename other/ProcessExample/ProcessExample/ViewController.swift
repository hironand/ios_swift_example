//
//  ViewController.swift
//  ProcessExample
//
//  Created by hironand on 2017/02/09.
//  Copyright © 2017年 appirca. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var envLabel: UILabel!
    @IBOutlet weak var envCopyLabel: UILabel!
    @IBOutlet weak var envUserDefLabel: UILabel!
    @IBOutlet weak var envUserDefCopyLabel: UILabel!
    @IBOutlet weak var envVarStruct: UILabel!
    
    var envVar: String?
    var envVarCopy: String?
    
    struct EnvVars {
        let var1: String
    }
    
    var envVars: EnvVars?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let app: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let userDefaults = app.userDefaults
        
        let env = ProcessInfo.processInfo.environment
        let envVar = env["ENV_VAR"]
        self.envVar = envVar
        
        userDefaults.set(envVar, forKey: "envVar")
        userDefaults.synchronize()
            
        
        var envVarCopy = ""
        if let envVar = envVar{
            envVarCopy += envVar
        }
        userDefaults.set(envVarCopy, forKey: "envVarCopy")
        userDefaults.synchronize()
        self.envVarCopy = envVarCopy
            
        if let ev = envVar {
            self.envVars = EnvVars(var1: ev)
        }
        
        
        envLabel.text = envVar
        envCopyLabel.text = self.envVarCopy
        envUserDefLabel.text = userDefaults.string(forKey: "envVar")
        envUserDefCopyLabel.text = userDefaults.string(forKey: "envVarCopy")
        
        envVarStruct.text = envVars?.var1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
    }


}

