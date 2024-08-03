//
//  PrivacyViewController.swift
//  RadioApp
//
//  Created by Иван Семенов on 31.07.2024.
//

import UIKit

final class PrivacyViewController: ViewController, PrivacyViewProtocol {
    // MARK: - Presenter
    var presenter: PrivacyPresenterProtocol!
    
    // MARK: - Private Properties
    private let scrollView = UIScrollView()
    private let privacyInfo = PrivacyInfo()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSections()
        setupVC()
        setupConstraints()
    }
    
    // MARK: - Private Methods
    private func makeSection(with title: String, description: String) -> UIStackView {
        let titleLabel = UILabel.makeLabel(
            font: .systemFont(ofSize: 18, weight: .semibold),
            color: .white,
            numberOfLines: 1
        )
        titleLabel.text = title
        
        let descriptionLabel = UILabel.makeLabel(
            font: .systemFont(ofSize: 16, weight: .medium),
            color: .gray,
            numberOfLines: 0,
            alignment: .justified
        )
        descriptionLabel.text = description
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stackView.axis = .vertical
        
        stackView.spacing = 10
        return stackView
    }
    
    private func setupSections() {
        let sectionsData = privacyInfo.getSectionsInfo()
        let allSections = sectionsData.map {
            makeSection(with: $0.title, description: $0.description)
        }
        let stackView = UIStackView(arrangedSubviews: allSections)
        stackView.axis = .vertical
        stackView.spacing = 20
        scrollView.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.width.equalTo(scrollView.snp.width).offset(-40)
        }
    }
    
    private func setupVC() {
        view.backgroundColor = .darkBlueApp
        view.addSubview(scrollView)
        scrollView.showsVerticalScrollIndicator = false
        title = "Privacy Policy".localized
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(14)
            make.bottom.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
