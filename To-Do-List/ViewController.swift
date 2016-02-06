//
//  ViewController.swift
//  To-Do-List
//
//  Created by Chase Drum on 12/22/15.
//  Copyright © 2015 Chase Drum. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var tField : UITextField!
    
    var items : [item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
    self.tableView.dataSource = self
    self.tableView.delegate = self
        
        
    
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Self.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let item = self.items[indexPath.row]
        cell.textLabel!.text = item.title
        return cell
        
    }
    
    
    @IBAction func addButtonPressed(sender: AnyObject) {
        alertPopUp()
        
    }
    
    func configurationTextField(textField:UITextField) {
        textField.placeholder = "Enter New Item"
        self.tField = textField
    }
    
    func saveNewItem() {
        print("Item Saved")
        
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        let item = NSEntityDescription.insertNewObjectForEntityForName("Item", inManagedObjectContext: context) as! Item
        
        item.title = tField.text
        
        do {
            
            try context.save
        } catch _ {
            
        }
        
        let request = NSFetchRequest(entityName: "Item")
        var results : [AnyObject]?
        
        do {
            results = try context.executeFetchRequest(request)
        } catch _ {
            results = nil
        }
        
        if results != nil
            self.items = results as! [Item]
        
    }
    
    self.tableView.reloadData()
}

    
    
    func alertPopUp() {
        let alert = UIAlertController(title: "Add New Item", message: nil, preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) {
            UIAlertAction in
            alert.dismissViewControllerAnimated(true, completion: nil)
        }
        let saveAction = UIAlertAction(title: "Save", style: UIAlertActionStyle.default) {
            UIAlertAction in
            self.saveNewItem()
        }
        
        alert.addTextFieldWithConfigurationHandler(configurationTextField)
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    
    
}

