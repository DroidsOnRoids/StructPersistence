//
//  ShotView.swift
//  SquakersShots
//
//  Created by Michal Pyrka on 19/05/2017.
//  Copyright © 2017 Michal Pyrka. All rights reserved.
//

import UIKit

final class ShotView: UIView {
    
    let contentView = UIView()
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(contentView)
        contentView.addSubview(imageView)
        contentView.clipsToBounds = true
        
        [contentView, imageView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.leadingAnchor.constraint(equalTo: $0.superview!.leadingAnchor).isActive = true
            $0.topAnchor.constraint(equalTo: $0.superview!.topAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: $0.superview!.trailingAnchor).isActive = true
            if $0 == imageView {
                $0.bottomAnchor.constraint(equalTo: $0.superview!.bottomAnchor).isActive = true
            }
        }
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    func setupLayout() {
        backgroundColor = .white
        contentView.layer.cornerRadius = 8.0
        setupShadow()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupShadow()
    }
    
    private func setupShadow() {
        let path = UIBezierPath()
        let xOffset: CGFloat = 1.0
        let yOffset: CGFloat = 4.0
        path.move(to: CGPoint(x: xOffset, y: bounds.height + yOffset))
        path.addLine(to: CGPoint(x: bounds.width - xOffset, y: bounds.height + yOffset))
        path.addLine(to: CGPoint(x: bounds.width - xOffset, y: yOffset * 4))
        path.addLine(to: CGPoint(x: xOffset, y: yOffset * 4))
        path.close()
        layer.shadowPath = path.cgPath
        layer.shadowOpacity = 1.0
        layer.shadowColor = UIColor(colorLiteralRed: 237.0/255.0, green: 241.0/255.0, blue: 245.0/255.0, alpha: 1.0).cgColor
    }
}


