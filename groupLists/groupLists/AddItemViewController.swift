//
//  AddItemViewController.swift
//  groupLists
//
//  Created by bergerMacPro on 10/9/17.
//  Copyright © 2017 bergerMacPro. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController {

    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemNameTextField: UITextField!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var quantityStepperLabel: UILabel!
    @IBOutlet weak var quantityStepper: UIStepper!
    
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var userTextField: UITextField!
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var idTextField: UITextField!

    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var submitNewItemBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.init(red: 31.0/255.0, green: 40.0/255.0, blue: 51.0/255.0, alpha: 1)
        
        submitNewItemBtn.setTitleColor(UIColor.init(red: 102.0/255.0, green: 252.0/255.0, blue: 241.0/255.0, alpha: 1), for: UIControlState.normal)
        submitNewItemBtn.backgroundColor = UIColor.init(red: 197.0/255.0, green: 198.0/255.0, blue: 199.0/255.0, alpha: 1)
        submitNewItemBtn.layer.cornerRadius = 10
        submitNewItemBtn.addTarget(self, action: #selector(verifyValidAddition), for: .touchUpInside)
        
        backBtn.setTitleColor(UIColor.init(red: 102.0/255.0, green: 252.0/255.0, blue: 241.0/255.0, alpha: 1), for: UIControlState.normal)
        backBtn.backgroundColor = UIColor.init(red: 197.0/255.0, green: 198.0/255.0, blue: 199.0/255.0, alpha: 1)
        backBtn.layer.cornerRadius = 10
        backBtn.addTarget(self, action: #selector(returnToList), for: .touchUpInside)
        
        quantityStepper.value = 1.0
        quantityStepper.addTarget(self, action: #selector(updateStepperLabel), for: .touchUpInside)
        quantityStepper.tintColor = UIColor.init(red: 102.0/255.0, green: 252.0/255.0, blue: 241.0/255.0, alpha: 1)
        
        quantityStepperLabel.textColor = UIColor.init(red: 197.0/255.0, green: 198.0/255.0, blue: 199.0/255.0, alpha: 1)
        quantityLabel.textColor = UIColor.init(red: 197.0/255.0, green: 198.0/255.0, blue: 199.0/255.0, alpha: 1)
        userLabel.textColor = UIColor.init(red: 197.0/255.0, green: 198.0/255.0, blue: 199.0/255.0, alpha: 1)
        idLabel.textColor = UIColor.init(red: 197.0/255.0, green: 198.0/255.0, blue: 199.0/255.0, alpha: 1)
        itemNameLabel.textColor = UIColor.init(red: 197.0/255.0, green: 198.0/255.0, blue: 199.0/255.0, alpha: 1)
        descriptionLabel.textColor = UIColor.init(red: 197.0/255.0, green: 198.0/255.0, blue: 199.0/255.0, alpha: 1)
        
        quantityStepperLabel.text = String(Int(quantityStepper.value))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateStepperLabel() {
        quantityStepperLabel.text = String(Int(quantityStepper.value))
    }
    
    func verifyValidAddition(){
        
        //if any of the required fields are missing, determine which one and notify user
        if (itemNameTextField.text == "" || userTextField.text == "" || idTextField.text == "" || descriptionTextField.text == "") {
            
            if itemNameTextField.text == "" {
                print("A name must be provided before adding item to list")
            }
            
            if userTextField.text == "" {
                print("A valid userID must be provided before adding item to list")
            }
            
            if idTextField.text == "" {
                print("A valid ID must be provided before adding item to list")
            }
            
            if descriptionTextField.text == "" {
                print("A valid description must be provided before adding item to list")
            }
            
        //otherwise create new item
        } else {
            
            //instantiate new item with information provided by user
            let newItem = Item(name: itemNameTextField.text!, id: idTextField.text!, userID: idTextField.text!, description: descriptionTextField.text!, quantity: Int(quantityStepper.value))
            
            //add new item to corresponding event
            testItems.append(newItem)
            
            //print new list item count for debugging
            print(model.events[0].items.count)
            
            //return to list which will now display recently added item
            performSegue(withIdentifier: "returnToList", sender: self)
        }
    }
    
    func returnToList(){
        performSegue(withIdentifier: "returnToList", sender: self)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
