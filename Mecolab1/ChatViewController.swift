//
//  ChatViewController.swift
//  Mecolab1
//
//  Created by rene Acuña Hernández on 27-06-16.
//  Copyright © 2016 rene Acuña Hernández. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // Labels and Fields
    @IBOutlet weak var mensajeField: UITextField!
    
    //Table
    @IBOutlet weak var tableView2: UITableView!
    
    //Local Varaible
    var tuple = (String(),String())
    let defaults = NSUserDefaults.standardUserDefaults()
    
    //CoreData
    var messagesManager = MessagesManager()
    
    // Push Notification
    static let RefreshNewsFeedNotification = "Messages"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Table
        tableView2.delegate = self
        tableView2.dataSource = self

    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func scrollTableView()  {
        dispatch_async(dispatch_get_main_queue()) {
            () -> Void in
            self.tableView2.reloadData()
            if self.messagesManager.messages.count > 0 {
                self.scrollToBottomMessage()
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func receivedRefreshNewsFeedNotification(notification: NSNotification) {
        messagesManager.fetchContacts(tuple.1)
        scrollTableView()
    }
    

    
    func clear(){
        mensajeField.text = ""
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesManager.messages.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        view.endEditing(true)
        let selectedCell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        selectedCell.contentView.backgroundColor = UIColor.whiteColor()
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "Cell")
        if messagesManager.messages[indexPath.row].tipo == 1 {
            cell.textLabel?.textAlignment = .Right
        }
        else{
            cell.textLabel?.textAlignment = .Left
        }
        cell.textLabel?.text = messagesManager.messages[indexPath.row].contenido
        return cell
    }
    
    //Scroll to the botton
    func scrollToBottomMessage() {
        let bottomMessageIndex = NSIndexPath(forRow: self.tableView2.numberOfRowsInSection(0) - 1, inSection: 0)
        self.tableView2.scrollToRowAtIndexPath(bottomMessageIndex, atScrollPosition: .Bottom,animated: true)
    }
    
    
    
    func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            if view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
            else {
                
            }
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            if view.frame.origin.y != 0 {
                self.view.frame.origin.y += keyboardSize.height
            }
            else {
                
            }
        }
    }
    
}
