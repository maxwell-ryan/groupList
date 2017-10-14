//
//  EventCollectionViewController.swift
//  groupLists
//
//  Created by bergerMacPro on 10/13/17.
//  Copyright © 2017 bergerMacPro. All rights reserved.
//

import UIKit

private let reuseIdentifier = "eventCell"

var model = DataModel()
var testItems: [Item] = [Item(name: "name1", id: "id1", userID: "userID1"), Item(name: "name2", id: "id2", userID: "userID2"), Item(name: "name3", id: "id3", userID: "userID3")]
var testOrganizer = User(firstName: "John", lastName: "Doe", email: "john.doe@gmail.com", id: "1")



class EventCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //var eventController: EventController = EventController.init()
        
        //fill app model with test events
        
        //events.addEvent
        
        //events.events[idx]
        
        model.addEvent(name: "testEvent1", id: "eventID1", date: Date())
        model.addEvent(name: "testEvent2", id: "eventID2", date: Date.init(timeIntervalSinceNow: 5000.0))
        model.addEvent(name: "testEvent3", id: "eventID3", date: Date.init(timeIntervalSinceNow: 8000.0))
        model.addEvent(name: "testEvent4", id: "eventID4", date: Date.init(timeIntervalSinceNow: 9000.0))
        model.addEvent(name: "testEvent5", id: "eventID5", date: Date.init(timeIntervalSinceNow: 20000.0))
        model.addEvent(name: "testEvent6", id: "eventID6", date: Date.init(timeIntervalSinceNow: 80000.0))
        model.addEvent(name: "testEvent7", id: "eventID7", date: Date.init(timeIntervalSinceNow: 90000.0))
        model.addEvent(name: "testEvent8", id: "eventID8", date: Date.init(timeIntervalSinceNow: 109000.0))
        model.addEvent(name: "testEvent9", id: "eventID9", date: Date.init(timeIntervalSinceNow: 11235000.0))
        model.addEvent(name: "testEvent10", id: "eventID10", date: Date.init(timeIntervalSinceNow: 4355000.0))
        model.addEvent(name: "testEvent11", id: "eventID11", date: Date.init(timeIntervalSinceNow: 54645645000.0))
        print("EventCollectionView about to appear with \(model.events.count) events in the data model")
        
        let testOrganizer = User.init(firstName: "John", lastName: "Johnson", email: "testemail.com", id: "12")
        //fill each test event with test items
        for x in model.events {
            x.items = testItems
            x.organizer.append(testOrganizer)
            for y in x.items {
                print(y.name)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return model.events.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //cast cell as custom EventCollectionViewCell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventCell", for: indexPath) as! EventCollectionViewCell
        
        //set cell background color
        if (indexPath.item % 2 == 0) {
            cell.backgroundColor = colors.primaryColor1
        } else {
            cell.backgroundColor = UIColor.white
        }
        
        //populate custom cell with event information
        cell.eventNameLabel.text = model.events[indexPath.item].name
        cell.eventNameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        cell.eventNameLabel.textColor = colors.primaryColor2
        cell.eventDateLabel.text = model.events[indexPath.item].date.description
        cell.eventDateLabel.textColor = colors.primaryColor2
        cell.eventOrganizerLabel.textColor = colors.primaryColor2
        
        //NOTE: ADD ORGANIZER NAME ONCE DATA MODEL INFORMATION/STRUCTURE IMPLEMENTED FULLY
        //cell.eventOrganizerLabel.text = "\(model.events[indexPath.item].organizer[0].firstName) \(model.events[indexPath.item].organizer[0].lastName)"
        
        cell.layer.borderColor = colors.accentColor1.cgColor
        cell.layer.borderWidth = 1
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("Selected cell at path \(indexPath.item)")
        self.performSegue(withIdentifier: "displayList", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "displayList" {
            let selectedIndexPath = sender as! IndexPath
            let listVC = segue.destination as! ListViewController
            listVC.currentEventIdx = selectedIndexPath.item
        }
    }
    

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
