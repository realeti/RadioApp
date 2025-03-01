//
//  ProfileViewController.swift
//  RadioApp
//
//  Created by Иван Семенов on 30.07.2024.
//

import UIKit
import FirebaseAuth

final class ProfileViewController: ViewController, ProfileViewProtocol {
    private let presenter: ProfilePresenterProtocol
    private let userView = UserView()
    private let customSwitchSettingsView = CustomSwitchSettingsView()
    
    init(presenter: ProfilePresenterProtocol) {
        self.presenter = presenter
        presenter.getCurrentUser()
        super.init(nibName: nil, bundle: nil)
        playerIsHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var generalView = GeneralView(
        frame: .zero, title: "General".localized,
        firstTitle: "Notifications".localized,
        firstImage: .notification,
        secondTitle: "Language".localized,
        secondImage: .globe,
        showSwitchForFirst: true
    )
    
    private var moreView = GeneralView(
        frame: .zero, title: "More".localized,
        firstTitle: "Legal and Policies".localized,
        firstImage: .shield,
        secondTitle: "About Us".localized,
        secondImage: .alert
    )
    
    private lazy var LogOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log Out".localized, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.tintColor = .white
        button.backgroundColor = .neonBlueApp
        button.layer.cornerRadius = 24

        
        let action = UIAction() {_ in
            //self.saveButtonAction()
            let alertController = UIAlertController(title: "Do you want to Log Out?".localized, message: nil, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel))
            alertController.addAction(UIAlertAction(title: "Log Out".localized, style: .destructive
                                                    , handler: { _ in
                do {
                    try AuthenticationManager.shared.signOut()
                    //go to ondoarding + login flow
                    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                          let windowDelegate = windowScene.delegate as? SceneDelegate else { return }
                    windowDelegate.router?.startFlow()
                        print("Logged Out")
                    
                } catch {
                    print("Can't sign out")
                }
            }))
            self.present(alertController, animated: true, completion: nil)
        }
        button.addAction(action, for: .primaryActionTriggered)
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getCurrentUser()
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupButtons()
    }
    
    func update(with user: UserApp?) {
        guard let user else { return }
        userView.setViews(with: user)
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        view.addSubviews(userView, generalView, moreView, LogOutButton)
        setupConstraints()
        view.backgroundColor = .darkBlueApp
    }
    
    private func setupEditButton() {
        userView.editButtonTap = {
            self.presenter.showEditProfileVC()
        }
    }

    private func setupPoliciesButton() {
        moreView.onFirstTap = {
            self.presenter.showPolicyVC()
        }
    }
    
    private func setupAboutUsButton() {
        moreView.onSecondTap = {
            self.presenter.showAboutUsVC()
        }
    }
    
    private func setupLanguageViewButton() {
        generalView.onSecondTap = {
            self.presenter.showLanguageVC()
        }
    }
    
    private func setupButtons() {
        setupPoliciesButton()
        setupEditButton()
        setupPoliciesButton()
        setupAboutUsButton()
        setupLanguageViewButton()
    }
    
    func setupConstraints() {
        userView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
                .offset(20)
            make.left.equalToSuperview()
                .offset(20)
            make.right.equalToSuperview()
                .offset(-20)
            make.height.equalTo(80)
        }
        
        generalView.snp.makeConstraints { make in
            make.top.equalTo(userView.snp.bottom)
                .offset(20)
            make.left.equalToSuperview()
                .offset(20)
            make.right.equalToSuperview()
                .offset(-20)
            make.height.equalTo(210)
        }
        
        moreView.snp.makeConstraints { make in
            make.top.equalTo(generalView.snp.bottom)
                .offset(20)
            make.left.equalToSuperview()
                .offset(20)
            make.right.equalToSuperview()
                .offset(-20)
            make.height.equalTo(210)
        }
        
        LogOutButton.snp.makeConstraints { make in
            make.top.equalTo(moreView.snp.bottom)
                .offset(40)
            make.left.equalToSuperview()
                .offset(20)
            make.right.equalToSuperview()
                .offset(-20)
            make.height.equalTo(55)
        }
    }
}

