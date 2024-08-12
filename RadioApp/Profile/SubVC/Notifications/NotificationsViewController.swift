//
//  NotificationsViewController.swift
//  RadioApp
//
//  Created by Иван Семенов on 31.07.2024.
//

import UIKit

final class NotificationsViewController: ViewController, NotificationsVCProtocol {
    
    // MARK: - Presenter
    var presenter: NotificationsPresenterProtocol!
    
    // MARK: - Private UI Properties
    private var mainView: UIView = {
        var view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.gray.withAlphaComponent(0.3).cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    private var settingLabel: UILabel = {
        let label = UILabel.makeLabel(
            font: .systemFont(ofSize: 14, weight: .medium),
            color: .gray,
            numberOfLines: 1,
            alignment: .left
        )
        label.text = "Messages Notifications".localized
        return label
    }()
    
    private var notificationsLabel: UILabel = {
        let label = UILabel.makeLabel(
            font: .systemFont(ofSize: 16, weight: .medium),
            color: .white,
            numberOfLines: 1,
            alignment: .left
        )
        label.text = "Show Notifications".localized
        return label
    }()
    
    private var notificationSwitch: UISwitch = {
        var switcher = UISwitch()
        switcher.isOn = false
        switcher.onTintColor = .neonBlueApp
        
        return switcher
    }()
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setupConstraints()
        presenter.activate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: - NotificationsVCProtocol
    
    func update(isNotificationEnabled: Bool) {
        notificationSwitch.isOn = isNotificationEnabled
    }
    
    func showNotificationsAlert() {
        let alert = UIAlertController(
            title: "Error".localized,
            message: "NotificationAlertMessage".localized,
            preferredStyle: .alert
        )
        alert.addAction(
            .init(
                title: "OpenSettings".localized,
                style: .default,
                handler: {
                    _ in
                    
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                }
            )
        )
        alert.addAction(
            .init(
                title: "Close".localized,
                style: .cancel
            )
        )
        present(alert, animated: true)
    }
    
    // MARK: - Private Methods
    private func setViews() {
        view.backgroundColor = .darkBlueApp
        view.addSubview(mainView)
        mainView.addSubviews(settingLabel, notificationsLabel, notificationSwitch)
        title = "Notifications".localized
        notificationSwitch.addTarget(self, action: #selector(didChangeSwitch(_:)), for: .valueChanged)
    }
    
    private func setupConstraints() {
        mainView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
                .offset(LayoutConstraint.standardOffset)
            make.left.right.equalToSuperview()
                .inset(LayoutConstraint.standardOffset)
            make.height.equalTo(LayoutConstraint.mainViewHeight)
        }
        
        settingLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
                .offset(LayoutConstraint.settingLabelTopOffset)
            make.left.equalToSuperview()
                .offset(LayoutConstraint.labelLeftOffset)
        }
        
        notificationsLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
                .offset(LayoutConstraint.notificationsLabelBottomOffset)
            make.left.equalToSuperview()
                .offset(LayoutConstraint.labelLeftOffset)
        }
        
        notificationSwitch.snp.makeConstraints { make in
            make.centerY.equalTo(notificationsLabel.snp.centerY)
            make.right.equalToSuperview()
                .offset(-LayoutConstraint.standardOffset)
        }
    }
    
    @objc
    private func didChangeSwitch(_ switch: UISwitch) {
        presenter.didSwitchNotifications()
    }
}

// MARK: - LayoutConstraint
private enum LayoutConstraint {
    static let standardOffset: CGFloat = 20
    static let mainViewHeight: CGFloat = 140
    static let settingLabelTopOffset: CGFloat = 28
    static let labelLeftOffset: CGFloat = 16
    static let notificationsLabelBottomOffset: CGFloat = -28
}
