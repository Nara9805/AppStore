//
//  DetailViewController.swift
//  API1
//
//  Created by Smart Castle M1A2009 on 22.10.2023.
//

import UIKit
import Lottie

class DetailViewController: UIViewController {
    
    var animationView: LottieAnimationView?
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Expend4"
        label.textColor = .white
        label.font = .systemFont(ofSize: 22, weight: .medium)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "posterDemo")?.withRenderingMode(.alwaysOriginal)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Armed with every weapon they can get their hands on and the skills to use them!"
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .darkGray
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrowshape.backward"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate func setupUI() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        backButton.addTarget(self, action: #selector(handleBackPressed), for: .touchUpInside)
        
        
        view.backgroundColor = .lightGray
        
        view.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        
        view.addSubview(posterImageView)
        posterImageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20).isActive = true
        posterImageView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        posterImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        posterImageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        view.addSubview(descriptionLabel)
        descriptionLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 20).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: posterImageView.leftAnchor, constant: 0).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animationView = .init(name: "Animation - 1700379407022")
        animationView?.frame = view.bounds
        animationView?.contentMode = .scaleAspectFill
        animationView?.loopMode = .loop
        animationView?.animationSpeed = 0.5
        
        view.addSubview(animationView!)
        animationView?.play()
        
        setupUI()
    }
    
    @objc func handleBackPressed(button: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
