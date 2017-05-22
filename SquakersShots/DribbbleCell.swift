//
//  DribbbleCell.swift
//  SquakersShots
//
//  Created by Michal Pyrka on 19/05/2017.
//  Copyright © 2017 Michal Pyrka. All rights reserved.
//

import UIKit

final class DribbbleCell: UITableViewCell {
    
    let shotView = ShotView()
    private(set) var heartsLabel: UILabel!
    private(set) var commentsLabel: UILabel!
    private(set) var bucketsLabel: UILabel!
    private(set) var viewsLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    private func setupShotView() {
        shotView.layer.cornerRadius = 8.0
        contentView.addSubview(shotView)
        shotView.translatesAutoresizingMaskIntoConstraints = false
        shotView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        shotView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        shotView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        let bottomAnchor = shotView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20.0)
        //bottomAnchor.priority = UILayoutPriorityDefaultLow
        bottomAnchor.isActive = true
        shotView.contentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -60.0).isActive = true
        shotView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        let coverView = UIView()
        coverView.backgroundColor = .white
        contentView.addSubview(coverView)
        coverView.translatesAutoresizingMaskIntoConstraints = false
        coverView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        coverView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        coverView.heightAnchor.constraint(equalToConstant: 10.0).isActive = true
        coverView.bottomAnchor.constraint(equalTo: shotView.imageView.bottomAnchor, constant: 2.0).isActive = true
    }
    
    private func setupLayout() {
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        setupShotView()
        setupStackViews()
    }
    
    
    private func setupStackViews() {
        var stacks = zip(setupLabelsForStackView(), imageViewsForStackView()).map { tuple -> UIStackView in
            let stack = UIStackView(arrangedSubviews: [tuple.1, tuple.0])
            stack.spacing = 8.0
            
            return stack
        }
        let lastStack = stacks.popLast()!
        
        let leftStackView = UIStackView(arrangedSubviews: stacks)
        let rightStackView = UIStackView(arrangedSubviews: [lastStack, arrowImageView()])
        leftStackView.translatesAutoresizingMaskIntoConstraints = false
        rightStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(leftStackView)
        contentView.addSubview(rightStackView)
        leftStackView.spacing = 16.0
        rightStackView.spacing = 16.0
        leftStackView.leadingAnchor.constraint(equalTo: shotView.leadingAnchor, constant: 16.0).isActive = true
        leftStackView.bottomAnchor.constraint(equalTo: shotView.bottomAnchor, constant: -17.0).isActive = true
        rightStackView.trailingAnchor.constraint(equalTo: shotView.trailingAnchor, constant: -16.0).isActive = true
        rightStackView.bottomAnchor.constraint(equalTo: shotView.bottomAnchor, constant: -17.0).isActive = true
    }
    
    private func imageViewsForStackView() -> [UIImageView] {
        return [#imageLiteral(resourceName: "Heart"), #imageLiteral(resourceName: "Comment"), #imageLiteral(resourceName: "Bucket"), #imageLiteral(resourceName: "Eye")].map { image -> UIImageView in
            let imageView = UIImageView(image: image)
            imageView.tintColor = UIColor(colorLiteralRed: 136.0/255.0, green: 136.0/255.0, blue: 136.0/255.0, alpha: 1.0)
            imageView.contentMode = UIViewContentMode.scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            return imageView
        }
    }
    
    private func setupLabelsForStackView() -> [UILabel] {
        let bottomLabels = (0...3).map { _ -> UILabel in
            let label = UILabel()
            label.sizeToFit()
            let attributedString = NSMutableAttributedString()
            attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.black, range: NSRange(location: 0, length: attributedString.length))
            attributedString.addAttribute(NSKernAttributeName, value: CGFloat(2.0), range: NSRange(location: 0, length: attributedString.length))
            label.attributedText = attributedString
            label.font = UIFont.systemFont(ofSize: 13.0, weight: UIFontWeightMedium)
            
            return label
        }
        bottomLabels.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        heartsLabel = bottomLabels[0]
        commentsLabel = bottomLabels[1]
        bucketsLabel = bottomLabels[2]
        viewsLabel = bottomLabels[3]
        
        return bottomLabels
    }
    
    private func arrowImageView() -> UIImageView {
        let arrowImageView = UIImageView(image: #imageLiteral(resourceName: "Arrow"))
        arrowImageView.tintColor = .gray
        arrowImageView.contentMode = UIViewContentMode.scaleAspectFit
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return arrowImageView
    }
}
