//
//  ViewController.swift
//  RealmExample
//
//  Created by hironand on 2016/12/31.
//  Copyright © 2016年 hironand. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    @IBOutlet weak var personLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.savePerson()
        if let bob = findPerson(){
            self.personLabel.text = "\(bob.name!) is \(bob.age.value!) years old."
        } else {
            self.personLabel.text = "Taro is 30 years old."
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func savePerson(){
        
        let bob = Person()
        bob.name = "Bob"
        bob.age.value = 24
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(bob)
        }
    }
    
    private func findPerson() -> Person?{
        let realm = try! Realm()
        
        let bob = realm.objects(Person.self).first
        return bob
    }

}

