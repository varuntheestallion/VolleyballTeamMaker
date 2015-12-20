//
//  PositionControl.swift
//  AddPlayers
//
//  Created by Varun Mathuria on 10/29/15.
//  Copyright © 2015 VarunMathuria. All rights reserved.
//

import UIKit

class PositionControl: UIView {
    
    // Mark: Position Enum, Dict
    
    enum Position: Int {
        case LF = 0, CF, RF, LB, CB, RB
        static let allValues = [LF, CF, RF, LB, CB, RB]
    }
    
    static var fullPositionNames: [Position: String] = [
        .LF: "Left Forward", .CF: "Center Forward", .RF: "Right Forward",
        .LB: "Left Back", .CB: "Center Back", .RB: "Right Back"
    ]
    
    static var getEnumFromString: [String: Position] = [
        "Left Forward": .LF, "Center Forward": .CF, "Right Forward": .RF,
        "Left Back": .LB, "Center Back": .CB, "Right Back": .RB
    ]
    
    // MARK: Properties
    
    var preferredPosition = 0 {
    didSet {
        setNeedsLayout()
    }
    }
    var positionButtons = [UIButton]()
    var spacing = 10
    var numButtons = 6

    // MARK: Initialization
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        for pos in Position.allValues {
            let button = UIButton()
            button.backgroundColor = UIColor.grayColor()
            button.setTitle("\(pos)", forState: .Normal)
            button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            button.setTitleColor(UIColor.yellowColor(), forState: .Selected)
            button.setTitleColor(UIColor.yellowColor(), forState: [.Highlighted, .Selected])
            button.adjustsImageWhenHighlighted = false
            button.addTarget(self, action: "ratingButtonTapped:", forControlEvents: .TouchDown)
            positionButtons += [button]
            addSubview(button)
        }
    }
    
    // Offset each button's origin by the length of the button plus spacing.
    override func layoutSubviews() {
        // Set the button's width and height to a square the size of the frame's height.
        let buttonSize = Int(frame.size.height)
        var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        
        // Offset each button's origin by the length of the button plus some spacing.
        for (index, button) in positionButtons.enumerate() {
            buttonFrame.origin.x = CGFloat(index * (buttonSize + spacing))
            button.frame = buttonFrame
        }
        updateButtonSelectionStates()
    }
    
    override func intrinsicContentSize() -> CGSize {
        let buttonSize = Int(frame.size.height)
        let width = (buttonSize + spacing) * numButtons
        
        return CGSize(width: width, height: buttonSize)
    }
    
    // MARK: Button Action
    
    func ratingButtonTapped(button: UIButton) {
        preferredPosition = positionButtons.indexOf(button)!
        updateButtonSelectionStates()
    }
    
    func updateButtonSelectionStates() {
        for (index, button) in positionButtons.enumerate() {
            button.selected = index == preferredPosition
        }
    }

}
