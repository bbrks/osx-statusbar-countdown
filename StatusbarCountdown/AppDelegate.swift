//
//  AppDelegate.swift
//  StatusbarCountdown
//
//  Created by Ben Brooks on 31/03/2015.
//  Copyright (c) 2015 Ben Brooks. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    // TODO: Remove these hardcoded values (into a plist)
    // TODO: Provide a GUI config to set plist values
    let countToDate = NSDate(timeIntervalSince1970: 1431086400)
    let countdownName = "Diss"
    
    var showName = true
    var showSeconds = true

    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1)
    @IBOutlet weak var statusMenu: NSMenu!

    // Function runs when application has launched
    func applicationDidFinishLaunching(aNotification: NSNotification) {

        statusItem.title = ""
        statusItem.menu = statusMenu

        // Run tick() once a second
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "tick", userInfo: nil, repeats: true)

    }

    // Calculates the difference in time from now to the specified date and sets the statusItem title
    func tick() {
        var diff = secondsToTime(Int(countToDate.timeIntervalSinceNow))
        
        if (showName) {
            statusItem.title = countdownName + ": " + formatTime(diff)
        } else {
            statusItem.title = formatTime(diff)
        }
    
    }
    
    // Convert seconds to 5 Time integers (years, days, hours minutes and seconds)
    func secondsToTime (seconds : Int) -> (Int, Int, Int, Int, Int) {
        var years = seconds / (3600 * 24 * 365)
        var remainder = seconds % (3600 * 24 * 365)
        
        var days = remainder / (3600 * 24)
        remainder = remainder % (3600 * 24)
        
        var hours = remainder / 3600
        remainder = remainder % 3600
        
        var minutes = remainder / 60
        
        var seconds = remainder % 60
        
        return (years, days, hours, minutes, seconds)
    }
    
    // Convert 5 Time integers (years, days, hours minutes and seconds) to a string.
    // Display trailing zeros if required, otherwise trim.
    func formatTime(time: (Int, Int, Int, Int, Int)) -> (String) {
        let years   = (time.0 > 0)                                           ? String(time.0) + "y " : ""
        let days    = (time.1 > 0 || time.0 > 0)                             ? String(time.1) + "d " : ""
        let hours   = (time.2 > 0 || time.1 > 0 || time.0 > 0)               ? String(time.2) + "h " : ""
        let minutes = (time.3 > 0 || time.2 > 0 || time.1 > 0 || time.0 > 0) ? String(time.3) + "m" : ""
        let seconds = (showSeconds) ? " " + String(time.4) + "s" : ""
        return years + days + hours + minutes + seconds
    }
    
    // MenuItem click event to toggle showSeconds
    @IBAction func toggleShowSeconds(sender: NSMenuItem) {
        if (showSeconds) {
            showSeconds = false
            sender.state = NSOffState
        } else {
            showSeconds = true
            sender.state = NSOnState
        }
    }
    
    // MenuItem click event to toggle showName
    @IBAction func toggleShowName(sender: NSMenuItem) {
        if (showName) {
            showName = false
            sender.state = NSOffState
        } else {
            showName = true
            sender.state = NSOnState
        }
    }
    
    // MenuItem click event to quit application
    @IBAction func quitApplication(sender: NSMenuItem) {
        NSApplication.sharedApplication().terminate(self);
    }

}
