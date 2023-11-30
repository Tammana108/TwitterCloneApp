//
//  TweetTableViewCell.swift
//  TwitterClone
//
//  Created by Tammana on 30/11/23.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    static let identifier = "TweetTableViewCell"
    
    private var profileImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 25
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "person")
        return imageView
    }()
    
    private var displayName : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Tammana"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private var usernameLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "@tammana108"
        label.font = .systemFont(ofSize: 12, weight: .light)
        return label
    }()
    
    private var tweetContent : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "This is the dummy tweet Content. I am writing this tweet to test my UI. This text should be of multiple lines that is why i am writing multiple lines"
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    func configureConstraints(){
        contentView.addSubview(profileImageView)
        contentView.addSubview(displayName)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(tweetContent)
        let profileImageConstraints = [
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor , constant: 20),
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            profileImageView.heightAnchor.constraint(equalToConstant: 50),
            profileImageView.widthAnchor.constraint(equalToConstant: 50)
        ]
        let displayNameConstraints = [
            displayName.topAnchor.constraint(equalTo: contentView.topAnchor , constant: 20),
            displayName.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10)
        ]
        let usernameConstraints = [
            usernameLabel.leadingAnchor.constraint(equalTo: displayName.trailingAnchor, constant: 5),
            usernameLabel.centerYAnchor.constraint(equalTo: displayName.centerYAnchor, constant: 0)
           // usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ]
        let tweetContentConstraints = [
            tweetContent.topAnchor.constraint(equalTo: displayName.bottomAnchor , constant: 10),
            tweetContent.leadingAnchor.constraint(equalTo: displayName.leadingAnchor, constant: 0),
            tweetContent.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            tweetContent.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ]
        NSLayoutConstraint.activate(profileImageConstraints)
        NSLayoutConstraint.activate(displayNameConstraints)
        NSLayoutConstraint.activate(usernameConstraints)
        NSLayoutConstraint.activate(tweetContentConstraints)
        
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
