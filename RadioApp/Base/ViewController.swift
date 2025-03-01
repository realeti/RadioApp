//
//  ViewController.swift
//  RadioApp
//
//  Created by Мария Нестерова on 29.07.2024.
//

import UIKit
import SnapKit
import FirebaseAuth

class ViewController: UIViewController {
    private let storageManager = StorageManager.shared
    private let loadingView = LoadingView()
    private let errorView = ErrorView()
    var playerIsHidden: Bool = false
    var playerVolumeIsHidden: Bool = false
    private let nameTitle = UILabel()
    
    private lazy var profileView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
        setTabBarAttributes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let homeController = tabBarController as? HomeController {
            if playerIsHidden {
                homeController.playerIsHidden = true
            }
            
            if playerVolumeIsHidden {
                homeController.volumeIsHidden = true
            }
        }
        setUserData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let homeController = tabBarController as? HomeController {
            if playerIsHidden {
                homeController.playerIsHidden = false
            }
            
            if playerVolumeIsHidden {
                homeController.volumeIsHidden = false
            }
        }
    }
    
    private func configureItems() {
        //right
        setRightBarButtonItem()
        
        //left
        if navigationController?.viewControllers.first != self {
            navigationItem.leftBarButtonItem = .init(
                image: .backButton.withRenderingMode(.alwaysOriginal),
                style: .plain,
                target: self,
                action: #selector(didTapBackButton)
            )
        } else {
            navigationItem.leftBarButtonItem = createCustomItem()
        }
    }
    
    private func setRightBarButtonItem() {
        profileView.snp.makeConstraints { make in
            make.width.equalTo(40)
        }
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(self.didTapProfilePic)
        )
        profileView.addGestureRecognizer(tapGesture)
        let rightBarButtonItem = UIBarButtonItem(customView: profileView)
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    private func setTabBarAttributes() {
        guard let homeController = tabBarController as? HomeController else { return }
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = homeController.normalTabBarAttributes
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = homeController.selectedTabBarAttributes
        homeController.tabBar.standardAppearance = appearance
        homeController.tabBar.scrollEdgeAppearance = appearance
    }
    
    func setUserData() {
        profileView.image = setMask(for: storageManager.getUserImage())
        nameTitle.text = Auth.auth().currentUser?.displayName
    }
    
    private func setMask(for image: UIImage) -> UIImage {
        let mask: UIImage = .mask
        let size = image.size
        let renderer = UIGraphicsImageRenderer(size: size)
        let newImage = renderer.image { context in
            image.draw(in: CGRect(origin: .zero, size: size), blendMode: .normal, alpha: 1)
            mask.draw(in: CGRect(origin: .zero, size: size), blendMode: .destinationIn, alpha: 1)
        }
        return newImage
    }
    
    private func createCustomItem() -> UIBarButtonItem {
        let icon = UIImageView(image: .iconNoBg)
        icon.contentMode = .scaleAspectFit
        
        let greetingTitle = UILabel()
        greetingTitle.text = "Hello".localized
        greetingTitle.textColor = .white
        greetingTitle.font = .systemFont(ofSize: 25, weight: .medium)
        
        nameTitle.textColor = .pinkApp
        nameTitle.font = .systemFont(ofSize: 30, weight: .medium)
        
        let container = UIView()
        container.addSubview(icon)
        container.addSubview(greetingTitle)
        container.addSubview(nameTitle)
        
        icon.snp.makeConstraints { make in
            make.height.width.equalTo(33)
        }
        
        greetingTitle.snp.makeConstraints { make in
            make.leading.equalTo(icon.snp.trailing).offset(8)
            make.bottom.equalTo(icon.snp.bottom).inset(1)
        }
        
        nameTitle.snp.makeConstraints { make in
            make.leading.equalTo(greetingTitle.snp.trailing).offset(5)
            make.bottom.equalTo(icon)
        }
        
        container.snp.makeConstraints { make in
            make.leading.bottom.equalTo(icon)
            make.trailing.top.equalTo(nameTitle).inset(-6)
        }
        
        return UIBarButtonItem(customView: container)
    }
    
    @objc private func didTapBackButton() {
        if let navigationController {
            navigationController.popViewController(animated: true)
        } else {
            dismiss(animated: true)
        }
    }
    
    @objc private func didTapProfilePic() {
        //go to ProfileVC
        let profileVC = Builder.createProfile()
        guard let topVC = navigationController?.topViewController else { return }
        if topVC as? ProfileViewController == nil {
            navigationController?.pushViewController(profileVC, animated: true)
        }
    }
}

extension ViewController: LoadingPresenting {
    func showLoading() {
        loadingView.animation.play()
        view.addSubview(loadingView)
        loadingView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        loadingView.backgroundColor = .darkBlueApp
    }
    
    func hideLoading() {
        loadingView.animation.stop()
        loadingView.removeFromSuperview()
    }
}

extension ViewController: ErrorPresenting {
    func showError(
        isAlert: Bool,
        title: String,
        message: String?,
        actionTitle: String?,
        action: ((UIView) -> Void)?
    ) {
        errorView.title = title
        errorView.message = message
        errorView.actionTitle = actionTitle
        errorView.action = action
        
        view.addSubview(errorView)
        if isAlert {
            errorView.layer.cornerRadius = 24
            errorView.snp.makeConstraints {
                $0.center.equalToSuperview()
                $0.leading.trailing.equalToSuperview().inset(30)
                $0.height.equalToSuperview().dividedBy(3)
            }
        } else {
            errorView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        }
        errorView.animation.play()
    }
    
    func hideError() {
        errorView.removeFromSuperview()
    }
}
