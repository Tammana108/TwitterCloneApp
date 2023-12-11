//
//  TweetComposeViewController.swift
//  TwitterClone
//
//  Created by Tammana Sharma on 10/12/23.
//

import UIKit
import Combine

class TweetComposeViewController: UIViewController {
    private var subscriptions : Set<AnyCancellable> = []
    private let viewModel = TweetComposeViewViewModel()
    private let composeTweetButton : UIButton = {
        let button = UIButton()
        button.setTitle("Tweet", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .disabled)
        button.backgroundColor = .tweetBackgroundColor
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 8
        button.isEnabled = false
        return button
    }()
    
    private let tweetContentTextView : UITextView = {
        let textView = UITextView()
        textView.text = "What's happening?"
        textView.layer.masksToBounds = true
        textView.font = .systemFont(ofSize: 16, weight: .regular)
        textView.textColor = .gray
        textView.textContainerInset = .init(top: 15, left: 15, bottom: 15, right: 15)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    @objc func didTapCancel(){
        dismiss(animated: true)
    }
    
    @objc func didTapDismiss(){
        view.endEditing(true)
    }
    
    private func configureConstraints(){
        let composeTweetButtonConstraints = [
            composeTweetButton.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -10),
            composeTweetButton.widthAnchor.constraint(equalToConstant: 120),
            composeTweetButton.heightAnchor.constraint(equalToConstant: 50),
            composeTweetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ]
        
        let tweetContentTextViewConstraints = [
            tweetContentTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            tweetContentTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tweetContentTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tweetContentTextView.bottomAnchor.constraint(equalTo: composeTweetButton.topAnchor, constant: -15)
        
        ]
        
        NSLayoutConstraint.activate(composeTweetButtonConstraints)
        NSLayoutConstraint.activate(tweetContentTextViewConstraints)
    }
    
    @objc func didTapToTweet() {
        viewModel.dispatchTweet()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Tweet"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didTapCancel))
        tweetContentTextView.delegate = self
        view.addSubview(composeTweetButton)
        view.addSubview(tweetContentTextView)
        configureConstraints()
      
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapDismiss)))
        bindViews()
        composeTweetButton.addTarget(self, action: #selector(didTapToTweet), for: .touchUpInside)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getUserData()
    }
    private func bindViews() {
        viewModel.$isValidToTweet.sink {[weak self] status in
            self?.composeTweetButton.isEnabled = status
        }
        .store(in: &subscriptions)
        
        viewModel.$shouldDismissComposer.sink { [weak self] status in
            if status {
                self?.dismiss(animated: true)
            }
        }
        .store(in: &subscriptions)
    }
}

extension TweetComposeViewController : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .gray{
            textView.textColor = .label
            textView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.textColor = .gray
            textView.text = "What's happening?"
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        viewModel.tweetContent = textView.text
        viewModel.validateToTweet()
    }
}
