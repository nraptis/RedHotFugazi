//
//  ClippedImageView.swift
//  RedHotFugazi
//
//  Created by Nicky Taylor on 11/20/23.
//

import UIKit

class ClippedImageView: UIView {

    lazy var imageView: UIImageView = {
        let result = UIImageView(frame: .zero)
        result.translatesAutoresizingMaskIntoConstraints = false
        result.contentMode = .scaleAspectFill
        result.clipsToBounds = true
        result.layer.cornerRadius = 14.0
        result.backgroundColor = UIColor.red
        return result
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        self.addConstraints([
            imageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 2.0),
            imageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -2.0),
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 2.0),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2.0)
        ])
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

