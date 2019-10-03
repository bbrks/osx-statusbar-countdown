//
//  ShakeWindow.swift
//  StatusbarCountdown
//
//  Created by Jacqueline Alves on 02/10/19.
//  Copyright © 2019 Ben Brooks. All rights reserved.
//

import Cocoa

extension NSWindow {
    func shakeWindow(){
        let numberOfShakes          = 3
        let durationOfShake         = 0.3
        let vigourOfShake : CGFloat = 0.04
        let frame : CGRect = self.frame
        let shakeAnimation :CAKeyframeAnimation  = CAKeyframeAnimation()
        
        let shakePath = CGMutablePath()
        shakePath.move( to: CGPoint(x:NSMinX(frame), y:NSMinY(frame)))
        
        for _ in 0...numberOfShakes-1 {
            shakePath.addLine(to: CGPoint(x:NSMinX(frame) - frame.size.width * vigourOfShake, y:NSMinY(frame)))
            shakePath.addLine(to: CGPoint(x:NSMinX(frame) + frame.size.width * vigourOfShake, y:NSMinY(frame)))
        }
        
        shakePath.closeSubpath()
        shakeAnimation.path = shakePath
        shakeAnimation.duration = durationOfShake
        
        self.animations = ["frameOrigin":shakeAnimation]
        self.animator().setFrameOrigin(self.frame.origin)
    }
}
