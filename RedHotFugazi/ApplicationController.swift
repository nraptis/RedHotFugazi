//
//  ApplicationController.swift
//  RedHotFugazi
//
//  Created by Nicky Taylor on 11/20/23.
//

import Foundation

final class ApplicationController {
    
    static let shared = ApplicationController()
    private init() {
        
    }
    
    static var rootViewModel: RootViewModel!
    static var rootViewController: RootViewController!
    static let device = Device()
    
    static var widthPortrait: Float { device.widthPortrait }
    static var heightPortrait: Float { device.heightPortrait }
    static var widthLandscape: Float { device.widthLandscape }
    static var heightLandscape: Float { device.heightLandscape }
}
