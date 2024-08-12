//
//  CustomSwitchSettingsView.swift
//  RadioApp
//
//  Created by Иван Семенов on 05.08.2024.
//

import UIKit

protocol ConfigurableView: UIView {
    func configure(title: String, image: UIImage?)
}

final class CustomSwitchSettingsView: UIView {
    private let notificationManager = NotificationManager.shared
    
    private var iconBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    private var iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .white
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    private var switchControl: UISwitch = {
        let switcher = UISwitch()
        switcher.onTintColor = .neonBlueApp
        return switcher
    }()
    
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        setViews()
        setupConstraints()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    func configure(title: String, isOn: Bool, icon: UIImage?) {
        nameLabel.text = title
        switchControl.isOn = isOn
        if let icon = icon {
            iconView.image = icon
            iconBackgroundView.isHidden = false
        } else {
            iconBackgroundView.isHidden = true
        }
    }
    
    // MARK: - Private Methods
    private func setViews() {
        addSubviews(iconBackgroundView, nameLabel, switchControl)
        iconBackgroundView.addSubview(iconView)
    }
    
    private func setupConstraints() {
        iconBackgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.width.equalTo(32)
            make.left.equalToSuperview()
        }
        
        iconView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(22)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(iconBackgroundView.snp.right).offset(18)
            make.right.equalTo(switchControl.snp.left).offset(-8)
        }
        
        switchControl.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
    private func setupActions() {
        switchControl.addTarget(self, action: #selector(didToggleSwitch(_:)), for: .valueChanged)
    }
    
    // MARK: - Actions
    @objc private func didToggleSwitch(_ sender: UISwitch) {
        print("Switch toggled. Current state: \(sender.isOn)")
        if sender.isOn {
            notificationManager.requestAuthorization { [weak self] granted in
                DispatchQueue.main.async {
                    if granted {
                        self?.notificationManager.enableNotifications()
                        print("Notifications enabled.")
                    } else {
                        self?.showSettingsAlert()
                        sender.setOn(false, animated: true)
                    }
                }
            }
        } else {
            notificationManager.disableNotifications()
            print("Notifications disabled.")
        }
    }
    
    private func showSettingsAlert() {
        guard let viewController = self.findViewController() else { return }
        let alert = UIAlertController(
            title: "Notifications Disabled",
            message: "Please enable notifications in Settings",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Settings", style: .default) { _ in
            if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingsUrl)
            }
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        viewController.present(alert, animated: true)
    }
}

