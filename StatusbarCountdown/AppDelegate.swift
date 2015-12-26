//
//  AppDelegate.swift
//  StatusbarCountdown
//
//  Created by Ben Brooks on 31/03/2015.
//  Copyright (c) 2015 Ben Brooks. All rights reserved.
//

import Cocoa
import Foundation

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    // TODO: Remove these hardcoded values (into a plist)
    // TODO: Provide a GUI config to set plist values
    let countToDate = NSDate(timeIntervalSince1970: 1531086400)
    let countdownName = "Diss"
    
    var showName = true
    var showSeconds = true
    var zeroPad = false

    var formatter = NSNumberFormatter()

    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1)
    @IBOutlet weak var statusMenu: NSMenu!

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        statusItem.title = ""
        statusItem.menu = statusMenu
        formatter.minimumIntegerDigits = zeroPad ? 2 : 1

        NSTimer.scheduledTimerWithTimeInterval(0.25, target: self, selector: "tick", userInfo: nil, repeats: true)
    }

    // Calculates the difference in time from now to the specified date and sets the statusItem title
    func tick() {
        let diff = Int(countToDate.timeIntervalSinceNow)
        
        if (showName) {
            statusItem.title = countdownName + ": " + formatTime(diff)
        } else {
            statusItem.title = formatTime(diff)
        }
    
    }
    
    // Convert seconds to 4 Time integers (days, hours minutes and seconds)
    func secondsToTime (seconds : Int) -> (Int, Int, Int, Int) {
        let days = seconds / (3600 * 24)
        var remainder = seconds % (3600 * 24)
        
        let hours = remainder / 3600
        remainder = remainder % 3600
        
        let minutes = remainder / 60
        
        let seconds = remainder % 60
        
        return (days, hours, minutes, seconds)
    }
    
    // Display seconds as Days, Hours, Minutes, Seconds.
    func formatTime(time: Int) -> (String) {
        let time = secondsToTime(time)
        let days    = (time.0 > 0)                             ? String(time.0) + "d " : ""
        let hours   = (time.1 > 0 || time.0 > 0)               ? formatter.stringFromNumber(time.1)! + "h " : ""
        let minutes = (time.2 > 0 || time.1 > 0 || time.0 > 0) ? formatter.stringFromNumber(time.2)! + "m" : ""
        let seconds = (showSeconds) ? " " + formatter.stringFromNumber(time.3)! + "s" : ""
        return days + hours + minutes + seconds
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

    // MenuItem click event to toggle zeroPad
    @IBAction func toggleZeroPad(sender: NSMenuItem) {
        if (zeroPad) {
            zeroPad = false
            sender.state = NSOffState
        } else {
            zeroPad = true
            sender.state = NSOnState
        }
        formatter.minimumIntegerDigits = zeroPad ? 2 : 1
    }

    // MenuItem click event to quit application
    @IBAction func quitApplication(sender: NSMenuItem) {
        NSApplication.sharedApplication().terminate(self);
    }

}
