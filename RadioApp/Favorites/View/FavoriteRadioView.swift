//
//  FavoriteRadioView.swift
//  RadioApp
//
//  Created by Natalia on 30.07.2024.
//

import UIKit

class FavoriteRadioView: UIView, CellConfigurable {
    
    private var favoriteHandler: (() -> Void)?
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .white
        return label
    }()
    
    private let waveView = WaveView(
        waveColor: .white,
        circlesColor: ColorFactory.getRandomCircleColor()
    )
    
    private lazy var favButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "favOn"), for: .normal)
        button.addTarget(self, action: #selector(favButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let stackView: UIStackView = {
       let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .leading
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        self.layer.borderColor = UIColor.stormyBlue.cgColor
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 2
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(stackView)
        addSubview(favButton)
        stackView.addArrangedSubview(genreLabel)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(waveView)
    }
    
    private func setConstraints() {
        stackView.snp.makeConstraints { 
            $0.top.equalToSuperview().inset(18)
            $0.leading.equalToSuperview().inset(22)
            $0.bottom.equalToSuperview().inset(15)
        }
        
        favButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(31)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        waveView.snp.makeConstraints {
            $0.height.equalTo(22)
        }
    }
    
    @objc private func favButtonTapped() {
        favoriteHandler?()
    }
    
    func update(with model: FavStationModel?) {
        titleLabel.text = model?.radioTitle
        genreLabel.text = model?.genre
        favoriteHandler = model?.favoriteHandler
    }
}
