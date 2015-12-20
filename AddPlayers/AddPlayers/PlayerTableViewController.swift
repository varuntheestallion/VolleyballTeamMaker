//
//  PlayerTableViewController.swift
//  AddPlayers
//
//  Created by Varun Mathuria on 10/30/15.
//  Copyright © 2015 VarunMathuria. All rights reserved.
//

import UIKit

class PlayerTableViewController: UITableViewController {

    // MARK: Properties
    var players = [Player]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem()
        
        // Load any saved players, otherwise load sample data.
        if let savedPlayers = loadPlayers() {
            players += savedPlayers
        } else {
            // Load the sample data.
            loadSamplePlayers()
        }
    
    }
    
    func loadSamplePlayers() {
        let player1 = Player(name: "Bob Jones", preferredPosition: PositionControl.Position.CF)!
        let player2 = Player(name: "Fookie Bookie", preferredPosition: PositionControl.Position.LB)!
        let player3 = Player(name: "Future Hendrix", preferredPosition: PositionControl.Position.RF)!
        players += [player1, player2, player3]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "PlayerTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! PlayerTableViewCell
        
        // Fetches the appropriate player for the data source layout.
        let player = players[indexPath.row]

        cell.nameLabel.text = player.name
        cell.positionLabel.text = PositionControl.fullPositionNames[player.preferredPosition]

        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            players.removeAtIndex(indexPath.row)
            savePlayers()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            let playerDetailViewController = segue.destinationViewController as! PlayerViewController
            // Get the cell that generated this segue.
            if let selectedPlayerCell = sender as? PlayerTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedPlayerCell)!
                let selectedPlayer = players[indexPath.row]
                playerDetailViewController.player = selectedPlayer
            }
        } else if segue.identifier == "AddItem" {
            print("Adding new player.")
        }
    }

    @IBAction func unwindToPlayerList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? PlayerViewController, player = sourceViewController.player {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing player.
                players[selectedIndexPath.row] = player
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            } else {
                // Add a new player.
                let newIndexPath = NSIndexPath(forRow: players.count, inSection: 0)
                players.append(player)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
            // Save the player.
            savePlayers()
        }
    }
    
    // MARK: NSCoding
    
    func savePlayers() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(players, toFile: Player.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save players...")
        }
    }
    
    func loadPlayers() -> [Player]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Player.ArchiveURL.path!) as? [Player]
        
    }
    
}
