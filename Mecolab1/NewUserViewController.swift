//
//  NewUserViewController.swift
//  Mecolab1
//
//  Created by rene Acuña Hernández on 14-06-16.
//  Copyright © 2016 rene Acuña Hernández. All rights reserved.
//

import UIKit
import ContactsUI

class NewUserViewController: UIViewController {


    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    
    @IBAction func back(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func clear(){
        //self.textFieldName.text = ""
       // self.textFieldNumber.text = ""
       // self.textFieldPassword.text = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    



}
