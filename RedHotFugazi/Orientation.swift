//
//  Orientation.swift
//  RedHotFugazi
//
//  Created by Nicky Taylor on 11/20/23.
//

import UIKit

enum Orientation {
    case landscape
    case portrait
    init(interfaceOrientation: UIInterfaceOrientation) {
        switch interfaceOrientation {
        case .portrait, .portraitUpsideDown:
            self = .portrait
        case .landscapeLeft, .landscapeRight:
            self = .landscape
        default:
            self = .portrait
        }
    }
    
    init(deviceOrientation: UIDeviceOrientation) {
        switch deviceOrientation {
        case .portrait, .portraitUpsideDown:
            self = .portrait
        case .landscapeLeft, .landscapeRight:
            self = .landscape
        default:
            self = .portrait
        }
    }
    var isPortrait: Bool {
        switch self {
        case .landscape:
            return false
        case .portrait:
            return true
        }
    }
    var isLandscape: Bool {
        switch self {
        case .landscape:
            return true
        case .portrait:
            return false
        }
    }
}

extension Orientation: CustomStringConvertible {
    var description: String {
        switch self {
        case .portrait:
            return "[P]"
        case .landscape:
            return "[L]"
        }
    }
}

extension UIInterfaceOrientationMask: CustomStringConvertible {
    public var description: String {
        var listOfMasks = [String]()
        if contains(.portrait) {
            listOfMasks.append("P")
        }
        if contains(.portraitUpsideDown) {
            listOfMasks.append("P-U")
        }
        if contains(.landscapeLeft) {
            listOfMasks.append("L-L")
        }
        if contains(.landscapeRight) {
            listOfMasks.append("L-R")
        }
        var string = "{"
        var index = 0
        while index < listOfMasks.count {
            string += listOfMasks[index]
            index += 1
            if index < listOfMasks.count {
                string += ", "
            }
        }
        string += "}"
        return string
    }
}

extension UIInterfaceOrientation: CustomStringConvertible {
    public var description: String {
        switch self {
        case .unknown:
            return "(?)"
        case .portrait:
            return "(P)"
        case .portraitUpsideDown:
            return "(U)"
        case .landscapeLeft:
            return "(LL)"
        case .landscapeRight:
            return "(LR)"
        default:
            return "(X)"
        }
    }
}
