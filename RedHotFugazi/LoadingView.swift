//
//  ViewController.swift
//  RedHotFugazi
//
//  Created by Nicky Taylor on 11/20/23.
//

import UIKit

class LoadingView: UIView {

    lazy var activityIndicator: UIActivityIndicatorView = {
        let result = UIActivityIndicatorView(frame: .zero)
        result.translatesAutoresizingMaskIntoConstraints = false
        result.style = .large
        result.color = .ghost
        return result
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: activityIndicator, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: activityIndicator, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        ])
        
        hide()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show() {
        activityIndicator.startAnimating()
        isHidden = false
        isUserInteractionEnabled = true
    }
    
    func hide() {
        activityIndicator.stopAnimating()
        isHidden = true
        isUserInteractionEnabled = false
    }
}
