//
//  PlayerViewController.swift
//  AddPlayers
//
//  Created by Varun Mathuria on 10/29/15.
//  Copyright © 2015 VarunMathuria. All rights reserved.
//

import UIKit

class PlayerViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Properties
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var positionControl: PositionControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var player: Player?
    var currentPosition = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text field’s user input through delegate callbacks.
        nameTextField.delegate = self
        
        // Set up views if editing an existing Player.
        if let player = player {
            navigationItem.title = player.name
            nameTextField.text   = player.name
            positionControl.preferredPosition = player.preferredPosition.rawValue
            currentPosition = player.currentPosition.rawValue
        }
        
        // Enable the Save button only if the text field has a valid Player name.
        checkValidPlayerName()
    }

    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidPlayerName()
        navigationItem.title = textField.text
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.enabled = false
    }
    
    func checkValidPlayerName() {
        // Disable the Save button if the text field is empty.
        let text = nameTextField.text ?? ""
        saveButton.enabled = !text.isEmpty
    }
    
    // MARK: Navigation
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddPlayerMode = presentingViewController is UINavigationController
        if isPresentingInAddPlayerMode {
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            navigationController!.popViewControllerAnimated(true)
        }
    }
    
    // This method lets you configure a view controller before it's presented.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            let name = nameTextField.text ?? ""
            let preferredPosition = positionControl.preferredPosition
            
            // Set the player to be passed to PlayerTableViewController after the unwind segue.
            player = Player(name: name, preferredPosition: PositionControl.Position.allValues[preferredPosition], currentPosition: PositionControl.Position.allValues[currentPosition])
        }
    }

}

