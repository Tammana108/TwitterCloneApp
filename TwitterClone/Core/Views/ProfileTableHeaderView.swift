//
//  ProfileTableHeaderView.swift
//  TwitterClone
//
//  Created by Tammana on 04/12/23.
//

import UIKit

class ProfileTableHeaderView: UIView {
    
    private let profileHeaderImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profileHeader")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        
    }()
    
    private let profileAvatarImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 40
        imageView.backgroundColor = .systemYellow
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        
    }()
    
    private let displayNameLabel : UILabel = {
        let label = UILabel()
        label.text = "Tammana Sharma"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let userNameLabel : UILabel = {
        let label = UILabel()
        label.text = "@tammana108"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    private let userBioLabel : UILabel = {
        let label = UILabel()
        label.text = "iOS Developer"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.numberOfLines = 3
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    private let joinDateImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "calendar", withConfiguration: UIImage.SymbolConfiguration(pointSize: 14))
        imageView.tintColor = .secondaryLabel
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let joinDateLabel : UILabel = {
        let label = UILabel()
        label.text = "Joined May 2021"
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(profileHeaderImageView)
        addSubview(profileAvatarImageView)
        addSubview(displayNameLabel)
        addSubview(userNameLabel)
        addSubview(userBioLabel)
        addSubview(joinDateImageView)
        addSubview(joinDateLabel)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureConstraints(){
        let profileHeaderImageViewConstraints = [
            profileHeaderImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            profileHeaderImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            profileHeaderImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            profileHeaderImageView.heightAnchor.constraint(equalToConstant: 150)
        ]
        
        let profileAvatarImageViewConstraints = [
            profileAvatarImageView.centerYAnchor.constraint(equalTo: profileHeaderImageView.bottomAnchor, constant: 0),
            profileAvatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            profileAvatarImageView.heightAnchor.constraint(equalToConstant: 80),
            profileAvatarImageView.widthAnchor.constraint(equalToConstant: 80)
        ]
        
        let displayNameLabelConstraints = [
            displayNameLabel.topAnchor.constraint(equalTo: profileAvatarImageView.bottomAnchor, constant: 20),
            displayNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            displayNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ]
        
        let userNameLabelConstraints = [
            userNameLabel.topAnchor.constraint(equalTo: displayNameLabel.bottomAnchor, constant: 5),
            userNameLabel.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor, constant: 0),
            userNameLabel.trailingAnchor.constraint(equalTo: displayNameLabel.trailingAnchor, constant: 0)
        ]
        
        let userBioLabelConstraints = [
            userBioLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 5),
            userBioLabel.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor, constant: 0),
            userBioLabel.trailingAnchor.constraint(equalTo: displayNameLabel.trailingAnchor, constant: 0)
        ]
        
        let joinDateImageViewConstraints = [
            joinDateImageView.topAnchor.constraint(equalTo: userBioLabel.bottomAnchor, constant: 5),
            joinDateImageView.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor, constant: 0),
        ]
        
        let joinDateLabelConstraints = [
            joinDateLabel.leadingAnchor.constraint(equalTo: joinDateImageView.trailingAnchor, constant: 10),
            joinDateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            joinDateLabel.bottomAnchor.constraint(equalTo: joinDateImageView.bottomAnchor, constant: 0)
        ]
        
        NSLayoutConstraint.activate(profileHeaderImageViewConstraints)
        NSLayoutConstraint.activate(profileAvatarImageViewConstraints)
        NSLayoutConstraint.activate(displayNameLabelConstraints)
        NSLayoutConstraint.activate(userNameLabelConstraints)
        NSLayoutConstraint.activate(userBioLabelConstraints)
        NSLayoutConstraint.activate(joinDateImageViewConstraints)
        NSLayoutConstraint.activate(joinDateLabelConstraints)
    }
    

}
