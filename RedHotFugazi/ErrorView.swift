//
//  ErrorView.swift
//  RedHotFugazi
//
//  Created by Nicky Taylor on 11/20/23.
//

import UIKit

class ErrorView: UIView {

    lazy var xImageView: UIImageView = {
        let result = UIImageView(frame: .zero)
        result.translatesAutoresizingMaskIntoConstraints = false
        result.contentMode = .scaleAspectFit
        result.clipsToBounds = true
        result.tintColor = UIColor.ghost
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 256, weight: .bold, scale: .large)
        if let image = UIImage(systemName: "x.square.fill", withConfiguration: symbolConfig) {
            result.image = image.withRenderingMode(.alwaysTemplate)
        }
        return result
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(xImageView)
        
        xImageView.addConstraints([
            NSLayoutConstraint(item: xImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 44.0),
            NSLayoutConstraint(item: xImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 44.0)
        ])
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: xImageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: xImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        ])
        
        hide()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show() {
        isHidden = false
        isUserInteractionEnabled = true
    }
    
    func hide() {
        isHidden = true
        isUserInteractionEnabled = false
    }
}

