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

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        addSubview(profileHeaderImageView)
        addSubview(profileAvatarImageView)
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
            profileAvatarImageView.widthAnchor.constraint(equalToConstant: 80),
            
            
        ]
        
        NSLayoutConstraint.activate(profileHeaderImageViewConstraints)
        NSLayoutConstraint.activate(profileAvatarImageViewConstraints)
    }
    

}
