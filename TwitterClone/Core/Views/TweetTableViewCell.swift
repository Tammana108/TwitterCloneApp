//
//  TweetTableViewCell.swift
//  TwitterClone
//
//  Created by Tammana on 30/11/23.
//

import UIKit

protocol TweetCellButtonsTappedDelegate : AnyObject {
    func replyButtonTapped()
    func likeButtonTapped()
    func retweetButtonTapped()
    func shareButtonTapped()
    
    
}

class TweetTableViewCell: UITableViewCell {
    static let identifier = "TweetTableViewCell"
    weak var delegate : TweetCellButtonsTappedDelegate?
    
    private var profileImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 25
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
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
        label.textAlignment = .left
        return label
    }()
    
    private var replyButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "bubble.left"), for: .normal)
        button.tintColor = .systemGray2
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var retweetButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.2.squarepath"), for: .normal)
        button.tintColor = .systemGray2
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var likeButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .systemGray2
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var shareButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.tintColor = .systemGray2
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var buttonStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureConstraints()
        configureButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapReply(){
        delegate?.replyButtonTapped()
    }
    @objc func didTapRetweet(){
        delegate?.retweetButtonTapped()
        
    }
    @objc func didTapLike(){
        delegate?.likeButtonTapped()
        
    }
    @objc func didTapShare(){
        delegate?.shareButtonTapped()
    }
    func configureButtons(){
        replyButton.addTarget(self, action: #selector(didTapReply), for: .touchUpInside)
        retweetButton.addTarget(self, action: #selector(didTapRetweet), for: .touchUpInside)
        likeButton.addTarget(self, action: #selector(didTapLike), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(didTapShare), for: .touchUpInside)
    }
    
    func configureConstraints(){
        contentView.addSubview(profileImageView)
        contentView.addSubview(displayName)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(tweetContent)
        contentView.addSubview(buttonStackView)
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
        ]
        
        let buttonStackViewConstraints = [
            buttonStackView.topAnchor.constraint(equalTo: tweetContent.bottomAnchor , constant: 10),
            buttonStackView.leadingAnchor.constraint(equalTo: tweetContent.leadingAnchor, constant: 10),
            buttonStackView.trailingAnchor.constraint(equalTo: tweetContent.trailingAnchor, constant: -15),
            buttonStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ]
        
        
        NSLayoutConstraint.activate(profileImageConstraints)
        NSLayoutConstraint.activate(displayNameConstraints)
        NSLayoutConstraint.activate(usernameConstraints)
        NSLayoutConstraint.activate(tweetContentConstraints)
        NSLayoutConstraint.activate(buttonStackViewConstraints)
        
        buttonStackView.addArrangedSubview(replyButton)
        buttonStackView.addArrangedSubview(retweetButton)
        buttonStackView.addArrangedSubview(likeButton)
        buttonStackView.addArrangedSubview(shareButton)
        
        
    }
 
    
}
