//
//  SettingsWindow.swift
//  StatusbarCountdown
//
//  Created by Jacqueline Alves on 02/10/19.
//  Copyright © 2019 Ben Brooks. All rights reserved.
//

import Cocoa

class SettingsWindow: NSWindowController, NSWindowDelegate {

    @IBOutlet weak var nameTextField: NSTextField!
    @IBOutlet weak var datePicker: NSDatePicker!
    @IBOutlet weak var nameBadInputFeedback: NSTextField!
    @IBOutlet weak var dateBadInputFeedback: NSTextField!
    
    var delegate: SettingsWindowDelegate?
    
    override func windowDidLoad() {
        super.windowDidLoad()

        self.window?.center() // Center the popover
        self.window?.makeKeyAndOrderFront(nil) // Make popover appear on top of anything else
        
        NSApp.activate(ignoringOtherApps: true) // Activate popover
        
        nameTextField.delegate = self
    }
    
    override var windowNibName : String! {
        return "SettingsWindow"
    }
    
    @IBAction func save(_ sender: Any) {
        if nameTextField.stringValue.trimmingCharacters(in: .whitespacesAndNewlines) == "" { // Check if name is empty
            nameBadInputFeedback.isHidden = false
            window?.shakeWindow()
            
        } else if datePicker.dateValue < Date() { // Check if date is after today
            dateBadInputFeedback.isHidden = false
            window?.shakeWindow()
            
        } else { // Everything is ok, save values to user defaults
            let defaults = UserDefaults.standard
            
            defaults.set(nameTextField.stringValue, forKey: "name")
            defaults.set(datePicker.dateValue, forKey: "date")
            
            delegate?.settingsDidUpdate()
            close()
        }
    }
    
    @IBAction func changeDatePicker(_ sender: Any) {
        dateBadInputFeedback.isHidden = true // Hide bad input feedback when change the date
    }
    
    @IBAction func closePopover(_ sender: Any) {
        close()
    }
}

extension SettingsWindow: NSTextFieldDelegate {
    func controlTextDidChange(_ obj: Notification) {
        nameBadInputFeedback.isHidden = true // Hide bad input feedback when something is entered on textfield
    }
}
