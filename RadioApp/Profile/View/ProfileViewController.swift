//
//  ProfileViewController.swift
//  RadioApp
//
//  Created by Иван Семенов on 30.07.2024.
//

import UIKit

final class ProfileViewController: ViewController, ProfileViewProtocol {
    private let presenter: ProfilePresenterProtocol
    private let userView = UserView()
    private let customSwitchSettingsView = CustomSwitchSettingsView()
    
    init(presenter: ProfilePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
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

            print("LogOut")
        }
        button.addAction(action, for: .primaryActionTriggered)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupButtons()
        
        //TODO: - настроить
        NotificationManager.shared.requestNotificationPermission()
        let notificationsEnabled = NotificationManager.shared.notificationsAreEnabled()
        customSwitchSettingsView.configure(title: "Enable Notifications", isOn: notificationsEnabled, icon: nil)
    }
        
    private func setupView() {
        view.addSubviews(userView, generalView, moreView, LogOutButton)
        setupConstraints()
        view.backgroundColor = .darkBlueApp
    }
    
    // MARK: - Private Methods
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

