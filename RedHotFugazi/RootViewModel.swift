//
//  RootViewModel.swift
//  RedHotFugazi
//
//  Created by Nicky Taylor on 11/20/23.
//

import UIKit

final class RootViewModel {
    var orientation: Orientation
    let window: UIWindow
    let windowScene: UIWindowScene
    init(orientation: Orientation,
         window: UIWindow,
         windowScene: UIWindowScene) {
        self.orientation = orientation
        self.window = window
        self.windowScene = windowScene
    }
}
