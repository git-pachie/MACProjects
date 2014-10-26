//
//  DetailViewController.swift
//  TestTableView3
//
//  Created by Archie Angeles on 27/10/14.
//  Copyright (c) 2014 PachieOrg. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var detail : Dictionary<String,String>!
    
    
    @IBOutlet weak var txtTask: UITextField!
    @IBOutlet weak var textDetail: UITextField!

    @IBOutlet weak var dateDate: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        txtTask.text = detail["task"]
        self.textDetail.text = detail["description"]
        //self.dateDate.date =
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
