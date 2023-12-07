//
//  HomeViewController.swift
//  TwitterClone
//
//  Created by Tammana on 30/11/23.
//

import UIKit
import FirebaseAuth
import Combine

class HomeViewController: UIViewController {
    
    private let viewModel = HomeViewViewModel()
    private var subscriptions : Set<AnyCancellable> = []
    var XLogo = UIImageView()
    private var tableView : UITableView = {
        let tableView = UITableView()
        tableView.register(TweetTableViewCell.self, forCellReuseIdentifier: TweetTableViewCell.identifier)
        return tableView
        
    }()
    
    func configureNavigationBar(){
        let size : CGFloat = 36
        XLogo = UIImageView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        setLogoImage()
        
        let titleView = UIImageView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        titleView.addSubview(XLogo)
        navigationItem.titleView = titleView
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person"), style: .plain, target: self, action: #selector(profileButtonTapped))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "rectangle.portrait.and.arrow.right"), style: .plain, target: self, action: #selector(signOutButtonTapped))
        
    }
    
    @objc func signOutButtonTapped(){
        try? Auth.auth().signOut()
        handleAuthentication()
    }
    @objc private func profileButtonTapped(){
        navigationController?.pushViewController(ProfileViewController(), animated: true)
    }
    
    private func setLogoImage(){
        if self.traitCollection.userInterfaceStyle == .dark{
            XLogo.image = UIImage(named: "XLogoDark")
        }
        else{
            XLogo.image = UIImage(named: "XLogoLight")
        }
    }
    
    private func handleAuthentication(){
        if Auth.auth().currentUser == nil {
            let navVC = UINavigationController(rootViewController: OnboardingViewController())
            navVC.modalPresentationStyle = .fullScreen
            present(navVC, animated: false)
            
        }
    }
    
    func completeUserOnboarding(){
        present(ProfileDataFormViewController(), animated: true)
        
    }
    
    func bindViews(){
        viewModel.$user.sink {[weak self] user in
            guard let user = user else { return }
            if !user.isUserOnboard {
                self?.completeUserOnboarding()
            }
        }
        .store(in: &subscriptions)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setLogoImage()
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.frame = view.bounds
        configureNavigationBar()
        bindViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        handleAuthentication()
        viewModel.retrieveUser()
    }
}

extension HomeViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TweetTableViewCell.identifier) as? TweetTableViewCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        return cell
    }
}

extension HomeViewController : TweetCellButtonsTappedDelegate {
    func replyButtonTapped() {
        print("Reply")
    }
    
    func likeButtonTapped() {
        print("Like")
    }
    
    func retweetButtonTapped() {
        print("Retweet")
    }
    
    func shareButtonTapped() {
        print("Share")
    }
    
    
}
