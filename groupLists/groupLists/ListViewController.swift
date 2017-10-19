//
//  ListViewController.swift
//  groupLists
//
//  Created by bergerMacPro on 10/9/17.
//  Copyright © 2017 bergerMacPro. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var eventController: EventController!
    var userController: UserController!
    var currentEventIdx: Int! //unwrapped optional required to prevent Xcode mandating this class have an initializer - let's discuss best practice, I am unsure
    
    @IBOutlet weak var addListItemBtn: UIButton!
    @IBOutlet weak var listItemTableView: UITableView!

    @IBOutlet weak var listInfoLabel: UILabel!
    @IBOutlet weak var listNameLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listItemTableView.reloadData()
        self.view.backgroundColor = UIColor.white  //colors.primaryColor1
        
        addListItemBtn.setTitleColor(colors.accentColor1, for: UIControlState.normal)
        addListItemBtn.backgroundColor = colors.primaryColor2
        addListItemBtn.layer.cornerRadius = 10
        addListItemBtn.addTarget(self, action: #selector(newItemSegue), for: UIControlEvents.touchUpInside)
        
        listItemTableView.dataSource = self
        listItemTableView.delegate = self
        
        listItemTableView.backgroundColor = colors.primaryColor1
        
        listInfoLabel.textColor = UIColor.init(red: 11.0/255.0, green: 12.0/255.0, blue: 16.0/255.0, alpha: 1)
        listInfoLabel.text = "Organized by \(eventController.events[currentEventIdx].organizer[0].firstName) \(eventController.events[currentEventIdx].organizer[0].lastName)    |    \(eventController.events[currentEventIdx].items.count) items suggested"
        
        listNameLabel.textColor = UIColor.init(red: 11.0/255.0, green: 12.0/255.0, blue: 16.0/255.0, alpha: 1)
        listNameLabel.text = eventController.events[currentEventIdx].name

    }
    
    override func viewWillAppear(_ animated: Bool) {
        listItemTableView.reloadData()
        print("ListViewController scoped on event idx: \(currentEventIdx!)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func newItemSegue() {
        performSegue(withIdentifier: "addItem", sender: self)
    }
    
//    func formerlyInViewDidLoad() {
//        listItemTableView.reloadData()
//        self.view.backgroundColor = UIColor.white  //colors.primaryColor1
//
//        addListItemBtn.setTitleColor(colors.accentColor1, for: UIControlState.normal)
//        addListItemBtn.backgroundColor = colors.primaryColor2
//        addListItemBtn.layer.cornerRadius = 10
//        addListItemBtn.addTarget(self, action: #selector(newItemSegue), for: UIControlEvents.touchUpInside)
//
//        listItemTableView.dataSource = self
//        listItemTableView.delegate = self
//
//        listItemTableView.backgroundColor = colors.primaryColor1
//
//        listInfoLabel.textColor = UIColor.init(red: 11.0/255.0, green: 12.0/255.0, blue: 16.0/255.0, alpha: 1)
//        listInfoLabel.text = "Organized by \(eventController.events[currentEventIdx].organizer[0].firstName) \(eventController.events[currentEventIdx].organizer[0].lastName)    |    \(eventController.events[currentEventIdx].items.count) items suggested"
//
//        listNameLabel.textColor = UIColor.init(red: 11.0/255.0, green: 12.0/255.0, blue: 16.0/255.0, alpha: 1)
//        listNameLabel.text = eventController.events[currentEventIdx].name
//    }
    
    //implement UITableViewDelegate and UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventController.events[currentEventIdx].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            let listItemCell = listItemTableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ListItemTableViewCell
            
            listItemCell.itemNameLabel.text = eventController.events[currentEventIdx].items[indexPath.row].name
            listItemCell.itemDescriptionLabel.text = eventController.events[currentEventIdx].items[indexPath.row].description
            listItemCell.itemUserLabel.text = "| Suggested by \(eventController.events[currentEventIdx].items[indexPath.row].userID) |"
            
            listItemCell.backgroundColor = colors.primaryColor1
            listItemCell.itemNameLabel.textColor = colors.primaryColor2
            listItemCell.itemDescriptionLabel.textColor = colors.primaryColor2
            
            listItemCell.itemUserLabel.textColor = colors.accentColor1
            
            
            return listItemCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //no implementation of row selection yet
        //could be used for detailed view of item information
        print("Selected row: \(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let edit = UITableViewRowAction(style: .default, title: "Edit") { (action: UITableViewRowAction, index: IndexPath) in
            let cell = tableView.cellForRow(at: indexPath)!
            cell.tag = indexPath.row
            self.performSegue(withIdentifier: "editItem", sender: cell)
        }
        
        edit.backgroundColor = UIColor.cyan
        
        let concur = UITableViewRowAction(style: .default, title: "Concur") { (action: UITableViewRowAction, index: IndexPath) in
            print("Concur button presss")
        }
        concur.backgroundColor = UIColor.green
        
        let disagree = UITableViewRowAction(style: .default, title: "Disagree") { (action: UITableViewRowAction, index: IndexPath) in
            print("Disagree button presss")
        }
        disagree.backgroundColor = UIColor.red
        
        return [disagree, concur, edit]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "editItem" {
            let selectedRow = sender as! ListItemTableViewCell
            print("selectedRow cell tag is: \(selectedRow.tag)")
            let destinationVC = segue.destination as! AddItemViewController
            
            destinationVC.eventController = self.eventController
            destinationVC.userController = self.userController
            destinationVC.id = self.userController.user.id
            destinationVC.userID = self.userController.user.id
            
            //maintain current event scope/idx
            destinationVC.currentEventIdx = self.currentEventIdx
            destinationVC.editIdx = selectedRow.tag
            print("In prepare sugue, currentEventIdx is scoped on: \(currentEventIdx)")

        } else if segue.identifier == "addItem" {
            
            let destinationVC = segue.destination as! AddItemViewController
            destinationVC.currentEventIdx = self.currentEventIdx
            destinationVC.eventController = self.eventController
            destinationVC.userController = self.userController
            destinationVC.id = self.userController.user.id
            destinationVC.userID = self.userController.user.id
        }
    }

}
