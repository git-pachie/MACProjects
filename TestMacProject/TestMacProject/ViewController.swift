//
//  ViewController.swift
//  TestMacProject
//
//  Created by Archie Angeles on 23/11/14.
//  Copyright (c) 2014 PachieOrg. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBAction func clicknow(sender: AnyObject) {
        
        self.txtText.stringValue = "Test value lang"
        
    }
    @IBOutlet weak var clickButton: NSButton!
    @IBOutlet weak var txtText: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

