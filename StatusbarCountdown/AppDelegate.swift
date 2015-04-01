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
    
    var showName = true
    
    let countToDate = NSDate(timeIntervalSince1970: 1431000000)
    let countdownName = "Diss"

    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1)
    @IBOutlet weak var statusMenu: NSMenu!

    func applicationDidFinishLaunching(aNotification: NSNotification) {

        statusItem.title = ""
        statusItem.menu = statusMenu

        // Run tick() once a second
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "tick", userInfo: nil, repeats: true)

    }

    func tick() {
        let now = NSDate()
        var diff = secondsToTime(Int(countToDate.timeIntervalSinceDate(now)))
        
        if (showName) {
            statusItem.title = countdownName + ": " + formatTime(diff)
        } else {
            statusItem.title = formatTime(diff)
        }
    
    }
    
    func secondsToTime (seconds : Int) -> (Int, Int, Int, Int, Int) {
        
        var forYears = seconds / (3600 * 24 * 365)
        var remainder = seconds % (3600 * 24 * 365)
        
        var forDays = remainder / (3600 * 24)
        remainder = remainder % (3600 * 24)
        
        var forHours = remainder / 3600
        remainder = remainder % 3600
        
        var forMinutes = remainder / 60
        var forSeconds = remainder % 60
        
        let s = forSeconds
        let m = forMinutes
        let h = forHours
        let d = forDays
        let y = forYears
        return (y, d, h, m, s)
    }
    
    func formatTime(time: (Int, Int, Int, Int, Int)) -> (String) {
        let y = (time.0 > 0) ? String(time.0) + "y " : ""
        let d = (time.1 > 0 || time.0 > 0) ? String(time.1) + "d " : ""
        let h = (time.2 > 0 || time.1 > 0 || time.0 > 0) ? String(time.2) + "h " : ""
        let m = (time.3 > 0 || time.2 > 0 || time.1 > 0 || time.0 > 0) ? String(time.3) + "m " : ""
        let s = String(time.4) + "s"
        return y + d + h + m + s
    }

    @IBAction func toggleShowName(sender: NSMenuItem) {
        if (showName) {
            showName = false
            sender.state = NSOffState
        } else {
            showName = true
            sender.state = NSOnState
        }
    }
    
    @IBAction func quitApplication(sender: NSMenuItem) {
        NSApplication.sharedApplication().terminate(self);
    }

}
