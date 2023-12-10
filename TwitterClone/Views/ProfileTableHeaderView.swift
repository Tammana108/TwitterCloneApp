//
//  ProfileTableHeaderView.swift
//  TwitterClone
//
//  Created by Tammana on 04/12/23.
//

import UIKit

private enum HeaderTabs : String{
    case tweets = "Tweets"
    case tweetsAndReplies = "Tweets & Replies"
    case media = "Media"
    case likes = "Likes"
}

class ProfileTableHeaderView: UIView {
    
    private var leadingConstraints : [NSLayoutConstraint] = []
    private var trailingConstraints : [NSLayoutConstraint] = []
    private var selectedTab : Int = 0 {
        didSet{
            for i in 0 ..< tabs.count{
                UIView.animate(withDuration: 0.3, delay: 0,options: .curveEaseInOut) {[weak self] in
                    self?.buttonStackView.arrangedSubviews[i].tintColor = i == self?.selectedTab ? .label : .secondaryLabel
                    self?.leadingConstraints[i].isActive = i == self?.selectedTab ? true : false
                    self?.trailingConstraints[i].isActive = i == self?.selectedTab ? true : false
                    self?.layoutIfNeeded()
                }
            }
        }
    }
    private let indicator : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    private let tabs : [UIButton] = ["Tweets", "Tweets & Replies", "Media", "Likes"].map { buttonTitle in
        let button = UIButton(type: .system)
        button.setTitle(buttonTitle, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.tintColor = .label
        return button
    }
    
    private lazy var buttonStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: tabs)
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
        
    }()
    
    private let profileHeaderImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profileHeader")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var profileAvatarImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 40
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        
    }()
    
    var displayNameLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    var userNameLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    var userBioLabel : UILabel = {
        let label = UILabel()
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
    
    var joinDateLabel : UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var followingCountLabel : UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let followingTextLabel : UILabel = {
        let label = UILabel()
        label.text = "Following"
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     var followersCountLabel : UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let followersTextLabel : UILabel = {
        let label = UILabel()
        label.text = "Followers"
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 15, weight: .regular)
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
        addSubview(followingCountLabel)
        addSubview(followingTextLabel)
        addSubview(followersCountLabel)
        addSubview(followersTextLabel)
        addSubview(buttonStackView)
        addSubview(indicator)
        configureConstraints()
        configureStackButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureStackButtons() {
        for (i, button) in buttonStackView.arrangedSubviews.enumerated() {
            guard let button = button as? UIButton else { return }
            
            if i == selectedTab {
                button.tintColor = .label
            }
            else{
                button.tintColor = .secondaryLabel
            }
            button.addTarget(self, action: #selector(didTabTapped), for: .touchUpInside)
        }
    }
    
    @objc func didTabTapped(sender : UIButton) {
        guard let label = sender.titleLabel?.text else { return }
        
        switch label {
        case HeaderTabs.tweets.rawValue:
            selectedTab = 0
        case HeaderTabs.tweetsAndReplies.rawValue:
            selectedTab = 1
        case HeaderTabs.media.rawValue:
            selectedTab = 2
        case HeaderTabs.likes.rawValue:
            selectedTab = 3
        default:
            selectedTab = 0
        }
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
        
        let followingCountLabelConstraints = [
            followingCountLabel.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor, constant: 0),
            followingCountLabel.topAnchor.constraint(equalTo: joinDateImageView.bottomAnchor , constant: 10)
        ]
        
        let followingTextLabelConstraints = [
            followingTextLabel.leadingAnchor.constraint(equalTo: followingCountLabel.trailingAnchor, constant: 5),
            followingTextLabel.topAnchor.constraint(equalTo: followingCountLabel.topAnchor , constant: 0),
        ]
        
        let followersCountLabelConstraints = [
            followersCountLabel.leadingAnchor.constraint(equalTo: followingTextLabel.trailingAnchor, constant: 10),
            followersCountLabel.topAnchor.constraint(equalTo: followingCountLabel.topAnchor , constant: 0)
        ]
        
        let followersTextLabelConstraints = [
            followersTextLabel.leadingAnchor.constraint(equalTo: followersCountLabel.trailingAnchor, constant: 5),
            followersTextLabel.topAnchor.constraint(equalTo: followingCountLabel.topAnchor , constant: 0),
            followersTextLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ]
        
        let buttonStackViewConstraints = [
            buttonStackView.topAnchor.constraint(equalTo: followingCountLabel.bottomAnchor, constant: 10),
            buttonStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            buttonStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            buttonStackView.heightAnchor.constraint(equalToConstant: 35)
        ]
        for i in 0 ..< tabs.count {
            let leadingConstraint = indicator.leadingAnchor.constraint(equalTo: buttonStackView.arrangedSubviews[i].leadingAnchor, constant: 0)
            leadingConstraints.append(leadingConstraint)
            
            let trailingConstraint = indicator.trailingAnchor.constraint(equalTo: buttonStackView.arrangedSubviews[i].trailingAnchor, constant: 0)
            trailingConstraints.append(trailingConstraint)
        }
        let indicatorConstraints = [
            leadingConstraints[0],
            trailingConstraints[0],
            indicator.topAnchor.constraint(equalTo: buttonStackView.arrangedSubviews[0].bottomAnchor, constant: 0),
            indicator.heightAnchor.constraint(equalToConstant: 4)
        ]
        
        NSLayoutConstraint.activate(profileHeaderImageViewConstraints)
        NSLayoutConstraint.activate(profileAvatarImageViewConstraints)
        NSLayoutConstraint.activate(displayNameLabelConstraints)
        NSLayoutConstraint.activate(userNameLabelConstraints)
        NSLayoutConstraint.activate(userBioLabelConstraints)
        NSLayoutConstraint.activate(joinDateImageViewConstraints)
        NSLayoutConstraint.activate(joinDateLabelConstraints)
        NSLayoutConstraint.activate(followingCountLabelConstraints)
        NSLayoutConstraint.activate(followingTextLabelConstraints)
        NSLayoutConstraint.activate(followersCountLabelConstraints)
        NSLayoutConstraint.activate(followersTextLabelConstraints)
        NSLayoutConstraint.activate(buttonStackViewConstraints)
        NSLayoutConstraint.activate(indicatorConstraints)
    }
    

}
