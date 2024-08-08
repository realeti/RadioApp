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
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
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
    
    private func getUserImage(completion: @escaping (UIImage?) -> Void) {
        guard let id = Auth.auth().currentUser?.uid else {
            completion(nil)
            return
        }
        StorageManager.shared.fetchUser(id: id) { result in
            switch result {
            case .success(let user):
                guard let imageData = user.imageData else {
                    completion(nil)
                    return
                }
                let image = UIImage(data: imageData)
                completion(image)
            case .failure(let error):
                completion(nil)
                print(error.localizedDescription)
            }
        }
    }
    
    private func setRightBarButtonItem() {
        getUserImage { image in
            DispatchQueue.main.async { [weak self] in
                let profileImage = image ?? .natalyaLuzyanina
                let view = PlayShapeView(image: profileImage)
                view.contentMode = .scaleAspectFit
                view.snp.makeConstraints { make in
                    make.height.width.equalTo(70)
                }
                let tapGesture = UITapGestureRecognizer(
                    target: self,
                    action: #selector(self?.didTapProfilePic)
                )
                view.addGestureRecognizer(tapGesture)
                let rightBarButtonItem = UIBarButtonItem(customView: view)
                self?.navigationItem.rightBarButtonItem = rightBarButtonItem
            }
        }
    }
    
    private func createCustomItem() -> UIBarButtonItem {
        let icon = UIImageView(image: .iconNoBg)
        icon.contentMode = .scaleAspectFit
        
        let greetingTitle = UILabel()
        greetingTitle.text = "Hello"
        greetingTitle.textColor = .white
        greetingTitle.font = .systemFont(ofSize: 25, weight: .medium)
        
        let nameTitle = UILabel()
        nameTitle.text = "Mark"
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
            make.bottom.equalTo(icon.snp.bottom).inset(1.8)
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
        profileVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(profileVC, animated: true)
    }
}

