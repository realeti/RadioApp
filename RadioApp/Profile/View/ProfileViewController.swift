//
//  ProfileViewController.swift
//  RadioApp
//
//  Created by Иван Семенов on 30.07.2024.
//

import UIKit

final class ProfileViewController: ViewController, ProfileViewProtocol {
    var presenter: ProfilePresenterProtocol!
    private let userView = UserView()
    
    private var generalView = GeneralView(
        frame: .zero, title: "General".localized,
        firstTitle: "Notifications".localized,
        firstImage: .notification,
        secondTitle: "Language".localized,
        secondImage: .globe
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
            let alertController = UIAlertController(title: "Do you want to Sign Out?", message: nil, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            alertController.addAction(UIAlertAction(title: "Sign Out", style: .destructive
                                                    , handler: { _ in
                do {
                    try AuthenticationManager.shared.signOut()
                    //go to ondoarding + login flow
                    let onboarding = OnboardingAssembly().build()
                    let navVC = UINavigationController()
                    navVC.navigationBar.isHidden = true
                    DispatchQueue.main.async { [weak self] in
                        let scenes = UIApplication.shared.connectedScenes
                        let windowScene = scenes.first as? UIWindowScene
                        windowScene?.keyWindow?.rootViewController = navVC
                        navVC.viewControllers = [onboarding]
                        print("Logged Out")
                    }
                } catch {
                    print("Can't sign out")
                }
            }))
            self.present(alertController, animated: true, completion: nil)
        }
        button.addAction(action, for: .primaryActionTriggered)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        updateUI()
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
    
//    private func setupNotificationButton() {
//        generalView.onFirstTap = {
//            self.presenter.showNotificationVC()
//        }
//    }
    
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
//        setupNotificationButton()
        setupPoliciesButton()
        setupAboutUsButton()
        setupLanguageViewButton()
    }
    
//    private func updateUI() {
//        guard let user = presenter.fetchUser() else { return }
//        userView.setViews(with: user)
//    }
     
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
