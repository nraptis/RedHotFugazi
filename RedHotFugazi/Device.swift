//
//  Device.swift
//  RedHotFugazi
//
//  Created by Nicky Taylor on 11/20/23.
//

import UIKit

class Device {
    
    let widthPortrait: Float
    let heightPortrait: Float
    let widthLandscape: Float
    let heightLandscape: Float
    
    static var isPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    static var isPhone: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }
    
    static var scale: Float {
        Float(UIScreen.main.scale)
    }
    
    init() {
        
        let _screenWidth = Float(Int(UIScreen.main.bounds.size.width + 0.5))
        let _screenHeight = Float(Int(UIScreen.main.bounds.size.height + 0.5))
        
        widthPortrait = _screenWidth < _screenHeight ? _screenWidth : _screenHeight
        heightPortrait = _screenWidth < _screenHeight ? _screenHeight : _screenWidth
        widthLandscape = heightPortrait
        heightLandscape = widthPortrait
    }
}
