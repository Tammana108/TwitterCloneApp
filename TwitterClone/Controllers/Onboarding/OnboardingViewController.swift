//
//  OnboardingViewController.swift
//  TwitterClone
//
//  Created by Tammana Sharma on 06/12/23.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    private let welcomeLabel : UILabel = {
        let label = UILabel()
        label.text = "See what's happening in the world right now."
        label.textColor = .label
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 38, weight: .bold)
        return label
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(welcomeLabel)
        configureConstraints()
    }
    
    func configureConstraints(){
        let welcomeLabelConstraints = [
            welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        
        NSLayoutConstraint.activate(welcomeLabelConstraints)
    }
 

}
