//
//  ShotsViewController.swift
//  SquakersShots
//
//  Created by Michal Pyrka on 19/05/2017.
//  Copyright © 2017 Michal Pyrka. All rights reserved.
//

import UIKit

final class ShotsViewController: UIViewController {

    private var titleLabel: UILabel?
    private var tabsStackView: UIStackView?
    private var popularLabel: UILabel?
    private let tableView = UITableView()
    private var dribbbleTableViewResponder = DribbbleTableViewResponder()
    private let dribbbleService = DribbbleService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(colorLiteralRed: 251.0/255.0, green: 251.0/255.0, blue: 251.0/255.0, alpha: 1.0)
        dribbbleService.loadShots { [unowned self] shots in
            self.dribbbleTableViewResponder.shots = shots.sorted { lhs, rhs in lhs.likes > rhs.likes }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        setupTitleLabel()
        setupTabLabels()
        setupHighlightView()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.backgroundColor = .clear
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(DribbbleCell.self, forCellReuseIdentifier: String(describing: DribbbleCell.self))
        tableView.delegate = dribbbleTableViewResponder
        tableView.dataSource = dribbbleTableViewResponder
        tableView.separatorColor = .clear
        view.addSubview(tableView)
        setupTableViewConstraints()
    }
    
    private func setupTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85, constant: 0.0).isActive = true
        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        if let tabsStackView = tabsStackView {
            tableView.topAnchor.constraint(equalTo: tabsStackView.topAnchor, constant: 56.0).isActive = true
        }
    }
    
    private func setupTitleLabel() {
        let label = UILabel()
        let chevron = UIImageView(image: #imageLiteral(resourceName: "Chevron"))
        chevron.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        let attributedString = NSMutableAttributedString(string: "Dribbble")
        attributedString.addAttribute(NSKernAttributeName, value: CGFloat(1.0), range: NSRange(location: 0, length: attributedString.length))
        label.attributedText = attributedString
        label.font = UIFont.systemFont(ofSize: 17.0, weight: UIFontWeightMedium)
        label.sizeToFit()
        view.addSubview(label)
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 32.0).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel = label
        view.addSubview(chevron)
        chevron.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 8.0).isActive = true
        chevron.centerYAnchor.constraint(equalTo: label.centerYAnchor).isActive = true
        setupNavbarIcons()
    }
    
    private func setupNavbarIcons() {
        let profileImageView = UIImageView(image: #imageLiteral(resourceName: "Profile"))
        let searchImageView = UIImageView(image: #imageLiteral(resourceName: "Search"))
        [profileImageView, searchImageView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        profileImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 32.0).isActive = true
        profileImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32.0).isActive = true
        
        searchImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 32.0).isActive = true
        searchImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32.0).isActive = true
    }
    
    private func setupTabLabels() {
        let tabOptions = ["Popular", "Recent", "Following", "Suggestions"]
        let tabLabels = tabOptions.map { text -> UILabel in
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            let attributedString = NSMutableAttributedString(string: text)
            attributedString.addAttribute(NSKernAttributeName, value: CGFloat(0.5), range: NSRange(location: 0, length: attributedString.length))
            label.attributedText = attributedString
            label.font = UIFont.systemFont(ofSize: 15.0, weight: UIFontWeightMedium)
            
            return label
        }
        
        popularLabel = tabLabels.first
        popularLabel?.textColor = .gray
        let stackView = UIStackView(arrangedSubviews: tabLabels)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        stackView.axis = .horizontal
        stackView.spacing = 24.0
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32.0).isActive = true
        if let titleLabel = titleLabel {
            stackView.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 48.0).isActive = true
        }
        tabsStackView = stackView
    }
    
    private func setupHighlightView() {
        let highlightView = UIView()
        highlightView.translatesAutoresizingMaskIntoConstraints = false
        highlightView.backgroundColor = UIColor(colorLiteralRed: 244.0/255.0, green: 79.0/255.0, blue: 132.0/255.0, alpha: 1.0)
        view.addSubview(highlightView)
        highlightView.heightAnchor.constraint(equalToConstant: 3.0).isActive = true
        highlightView.widthAnchor.constraint(equalToConstant: 58.0).isActive = true
        if let tabsStackView = tabsStackView {
            highlightView.leadingAnchor.constraint(equalTo: tabsStackView.leadingAnchor).isActive = true
            highlightView.bottomAnchor.constraint(equalTo: tabsStackView.bottomAnchor, constant: 10.0).isActive = true
        }
    }
}
