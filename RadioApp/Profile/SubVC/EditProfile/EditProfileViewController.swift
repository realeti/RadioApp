//
//  EditProfileViewController.swift
//  RadioApp
//
//  Created by Иван Семенов on 31.07.2024.
//

import UIKit
import FirebaseAuth

protocol EditProfileViewControllerProtocol: AnyObject {
    func fetchUser(_ user: UserApp)
    func updateRightBarButtonImage()
}

final class EditProfileViewController: ViewController, EditProfileViewControllerProtocol {
    // MARK: - Presenter
    var presenter: EditProfilePresenterProtocol!
    private let storageManager = StorageManager.shared
    
    let imageSelectionVC = ImageSelectionViewController()
    
    // MARK: - UI
    private lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        imageView.layer.cornerRadius = 60
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var editButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.backgroundColor = .darkGray
        button.tintColor = .neonBlueApp
        
        let buttonSize: CGFloat = 30
        button.frame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        button.layer.cornerRadius = buttonSize / 2
        button.clipsToBounds = true
        
        let action = UIAction() {_ in
            self.editButtonAction()
        }
        button.addAction(action, for: .primaryActionTriggered)
        return button
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel.makeLabel(
            font: .systemFont(ofSize: 18, weight: .bold),
            color: .white,
            numberOfLines: 1
        )
        label.backgroundColor = .darkBlueApp
        label.textAlignment = .center
        label.text = "MARK"
        return label
    }()
    
    private let userEmailLabel: UILabel = {
        let label = UILabel.makeLabel(
            font: .systemFont(ofSize: 16, weight: .medium),
            color: .white,
            numberOfLines: 1
        )
        label.backgroundColor = .darkBlueApp
        label.textAlignment = .center
        label.text = "mark@gmail.com"
        return label
    }()
    
    private let nameFieldView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 25
        return view
    }()
    
    private let loginLabel: UILabel = {
        let label = UILabel.makeLabel(
            font: .systemFont(ofSize: 12, weight: .medium),
            color: .white,
            numberOfLines: 1
        )
        label.backgroundColor = .darkBlueApp
        label.textAlignment = .center
        label.text = "Login".localized
        return label
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Enter your name".localized,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray.withAlphaComponent(0.5)]
        )
        textField.tag = 0
        textField.textColor = .white
        textField.autocorrectionType = .no
        return textField
    }()

    private var nameErrorLabel: UILabel = {
        var label = UILabel.makeLabel(
            font: .systemFont(ofSize: 12, weight: .medium),
            color: .systemRed,
            numberOfLines: 1
        )
        label.text = "* Required field".localized
        label.isHidden = true
        return label
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save Changes".localized, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.tintColor = .white
        button.backgroundColor = .neonBlueApp
        button.layer.cornerRadius = 24
        
        let action = UIAction() {_ in
            print("Save Changes")
            self.saveButtonAction()
        }
        button.addAction(action, for: .primaryActionTriggered)
        return button
    }()
    
    private lazy var updatePasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Update Password".localized, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        button.tintColor = .lightGray
        button.backgroundColor = .tealApp
        button.layer.cornerRadius = 24
        
        let action = UIAction() {_ in
            print("Update Password")
            self.updatePasswordButtonAction()
        }
        button.addAction(action, for: .primaryActionTriggered)
        return button
    }()
    
    private lazy var updateEmailButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Update Email".localized, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        button.tintColor = .lightGray
        button.backgroundColor = .tealApp
        button.layer.cornerRadius = 24
        
        let action = UIAction() {_ in
            print("Update Email")
            self.updateEmailButtonAction()
        }
        button.addAction(action, for: .primaryActionTriggered)
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.fetchUser()
        tabBarController?.tabBar.isHidden = true
        profileImage.image = storageManager.getUserImage()
    }
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        nameTextField.delegate = self
    }
    
    // MARK: - Private Methods
    private func setupViews() {
        view.backgroundColor = .darkBlueApp
        title = "Edit Profile".localized
        view.addSubviews(
            profileImage, editButton, userNameLabel, userEmailLabel,
            nameFieldView,
            loginLabel,
            nameErrorLabel, saveButton, updatePasswordButton, updateEmailButton
        )
        
        nameFieldView.addSubview(nameTextField)
        
    }
    
    func updateRightBarButtonImage() {
        self.setUserData()
    }
    
    private func saveButtonAction() {
        if let login = nameTextField.text,
           let imageData = profileImage.image?.pngData(),
           let id = Auth.auth().currentUser?.uid {
            var user = UserApp(id: id)
            user.image = imageData
            user.login = login
            presenter.saveUserData(user: user)
            nameTextField.text = nil
            nameErrorLabel.text = ""
        }
    }
    
    private func updatePasswordButtonAction() {
        let alertController = UIAlertController(title: "To update password you need to Sign In again".localized, message: nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel))
        alertController.addAction(UIAlertAction(title: "Sign In".localized, style: .destructive
                                                , handler: { _ in
            //go to reauthenticate flow
            self.presenter.reathenticate(mode: .password)
            print("Proceed to reauthenticate")
        }
                                               ))
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func updateEmailButtonAction() {
        let alertController = UIAlertController(title: "To update email you need to Sign In again".localized, message: nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel))
        alertController.addAction(UIAlertAction(title: "Sign In".localized, style: .destructive
                                                , handler: { _ in
            //go to reauthenticate flow
            self.presenter.reathenticate(mode: .email)
            print("Proceed to reauthenticate")
        }
                                               ))
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func editButtonAction() {
        imageSelectionVC.delegate = self
        present(imageSelectionVC, animated: true)
    }
    
    func fetchUser(_ user: UserApp) {
        userNameLabel.text = user.login
        userEmailLabel.text = user.email
//        profileImage.image = UIImage(data: user.image)
    }
    
    private func updateNameErrorLabel(login: String) {
        if let text = nameTextField.text, !text.isEmpty {
            let loginAvailability = presenter.isLoginBooked(login: login)
            nameErrorLabel.text = "* \(loginAvailability ? "Login already exist" : "Login Available")"
            nameErrorLabel.textColor = loginAvailability ? .red : .green
            nameErrorLabel.isHidden = false
        } else {
            nameErrorLabel.text = "* Required"
            nameErrorLabel.textColor = .red
            nameErrorLabel.isHidden = false
        }
    }
}
// MARK: - UITextFieldDelegate
extension EditProfileViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        switch textField.tag {
        case 0:
            updateNameErrorLabel(login: textField.text ?? "")
        default:
            break
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}


// MARK: - Setup Constraints
private extension EditProfileViewController {
    
    func setupConstraints() {
        profileImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
                .offset(EditViewLayout.topOffSetBlock)
            make.centerX.equalToSuperview()
            make.width.equalTo(EditViewLayout.userImageSize)
            make.height.equalTo(EditViewLayout.userImageSize)
        }
        
        editButton.snp.makeConstraints { make in
            make.bottom.equalTo(profileImage.snp.bottom)
                .offset(EditViewLayout.editButtonBottomOffset)
            make.right.equalTo(profileImage.snp.right)
                .offset(EditViewLayout.editButtonRightOffset)
            make.width.equalTo(EditViewLayout.editButtonSize)
            make.height.equalTo(EditViewLayout.editButtonSize)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom)
                .offset(EditViewLayout.topOrBottomOfSetItems)
            make.centerX.equalToSuperview()
            make.height.equalTo(EditViewLayout.topOrBottomOfSetItems)
        }
        
        userEmailLabel.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel.snp.bottom)
                .offset(EditViewLayout.topOrBottomOfSetItems)
            make.centerX.equalToSuperview()
            make.height.equalTo(EditViewLayout.topOrBottomOfSetItems)
        }
        
        nameFieldView.snp.makeConstraints { make in
            make.top.equalTo(userEmailLabel.snp.bottom)
                .offset(EditViewLayout.topOffSetBlock)
            make.left.right.equalToSuperview()
                .inset(EditViewLayout.textFieldLeftRightInset)
            make.height.equalTo(EditViewLayout.textFieldHeight)
        }
        
        loginLabel.snp.makeConstraints { make in
            make.top.equalTo(nameFieldView.snp.top).offset(EditViewLayout.nameEmailLabelTopOffset)
            make.left.equalTo(nameFieldView.snp.left)
                .offset(EditViewLayout.nameEmailLabelLeftOffset)
            make.width.equalTo(EditViewLayout.nameEmailLabelWidth)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
                .inset(EditViewLayout.textFieldLeftRightInset)
            make.top.equalToSuperview()
                .offset(EditViewLayout.topOrBottomOfSetItems)
            make.bottom.equalToSuperview()
                .offset(-EditViewLayout.topOrBottomOfSetItems)
        }
        
        nameErrorLabel.snp.makeConstraints { make in
            make.top.equalTo(nameFieldView.snp.bottom)
                .offset(EditViewLayout.topOrBottomOfSetItems)
            make.left.equalTo(nameFieldView.snp.left)
        }
        
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(nameErrorLabel.snp.bottom)
                .offset(EditViewLayout.topOrBottomOfSetItems + 4)
            make.left.right.equalToSuperview()
                .inset(EditViewLayout.textFieldLeftRightInset)
            make.height.equalTo(EditViewLayout.saveButtonHeight)
        }
        
        updatePasswordButton.snp.makeConstraints { make in
            make.top.equalTo(saveButton.snp.bottom)
                .offset(EditViewLayout.topOrBottomOfSetItems + 4)
            make.left.right.equalTo(saveButton)
            make.height.equalTo(saveButton)
        }
        
        updateEmailButton.snp.makeConstraints { make in
            make.top.equalTo(updatePasswordButton.snp.bottom)
                .offset(EditViewLayout.topOrBottomOfSetItems + 4)
            make.left.right.equalTo(saveButton)
            make.height.equalTo(saveButton)
        }
    }
    
    enum EditViewLayout {
        static let topOffSetBlock = 35
        static let topOrBottomOfSetItems = 10
        static let userImageSize = 120
        static let editButtonSize = 30
        static let textFieldHeight = 50
        static let textFieldLeftRightInset = 25
        static let nameEmailLabelTopOffset = -7
        static let nameEmailLabelLeftOffset = 35
        static let nameEmailLabelWidth = 80
        static let saveButtonBottomOffset = 50
        static let saveButtonHeight = 45
        static let editButtonBottomOffset = 3
        static let editButtonRightOffset = 5
    }
}

//MARK: - ImageSelectionDelegate
extension EditProfileViewController: ImageSelectionDelegate {
    func didUpdateProfileImage(_ image: UIImage) {
        profileImage.image = image
    }
}
