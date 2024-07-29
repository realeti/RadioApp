//
//  PopularCollectionViewCell.swift
//  RadioApp
//
//  Created by realeti on 29.07.2024.
//

import UIKit
import SnapKit

final class PopularCollectionViewCell: UICollectionViewCell {
    // MARK: - UI
    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        /// убрать отсюда установку цвета
        view.layer.borderColor = UIColor.stormyBlue.cgColor
        view.layer.borderWidth = 2
        return view
    }()
    
    private lazy var playImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(resource: .play)
        view.contentMode = .scaleAspectFit
        view.isHidden = true
        return view
    }()
    
    private lazy var voteStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var votesLabel: UILabel = {
        let label = UILabel()
        label.text = K.Popular.votes.rawValue + " "
        label.textColor = .white
        label.font = .systemFont(ofSize: 10.0, weight: .bold)
        return label
    }()
    
    private lazy var countVotesLabel: UILabel = {
        let label = UILabel()
        label.text = "315" + " "
        label.textColor = .white
        label.font = .systemFont(ofSize: 10.0, weight: .bold)
        return label
    }()
    
    private lazy var heartButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(.voteOn, for: .normal)
        return button
    }()
    
    private lazy var radioTitleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var radioTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "POP"
        label.textColor = .white
        label.font = .systemFont(ofSize: 30.0, weight: .bold)
        return label
    }()
    
    private lazy var radioSubtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Radio Record"
        label.textColor = .white
        label.font = .systemFont(ofSize: 15.0, weight: .regular)
        return label
    }()
    
    private lazy var radioSpacerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var namiImageView: UIImageView = {
        let view = UIImageView()
        view.image = .namiDarkRed
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                containerView.backgroundColor = .pinkApp
                containerView.layer.borderColor = nil
                playImageView.isHidden = false
            } else {
                containerView.backgroundColor = nil
                containerView.layer.borderColor = UIColor.stormyBlue.cgColor
                playImageView.isHidden = true
            }
        }
    }
    
    // MARK: - Cell Life Cycle
    override func prepareForReuse() {
        super.prepareForReuse()
        
        playImageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        /// update cornerRadius on containerView
        let radius = contentView.bounds.width * 0.1
        containerView.layer.cornerRadius = radius
    }
    
    // MARK: - Set Views
    private func setupUI() {
        contentView.addSubview(containerView)
        
        containerView.addSubviews(
            playImageView,
            voteStackView,
            radioTitleStackView
        )
        
        voteStackView.addArrangedSubviews(
            votesLabel,
            countVotesLabel,
            heartButton
        )
        
        radioTitleStackView.addArrangedSubviews(
            radioTitleLabel,
            radioSubtitleLabel,
            radioSpacerView,
            namiImageView
        )
    }
}

// MARK: - Setup Constraints
private extension PopularCollectionViewCell {
    func setupConstraints() {
        setupContainerViewConstraints()
        setupPlayImageConstraints()
        setupVoteStackViewConstraints()
        setupHeartButtonConstraints()
        setupRadioTitleStackViewConstraints()
        setupRadioSpacerViewConstraints()
    }
    
    func setupContainerViewConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setupPlayImageConstraints() {
        playImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Metrics.playImageTopIndent)
            make.leading.equalToSuperview().inset(Metrics.playImageLeadingIndent)
            make.width.height.equalToSuperview().multipliedBy(0.2)
        }
    }
    
    func setupVoteStackViewConstraints() {
        voteStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Metrics.votesStackTopIndent)
            make.trailing.equalToSuperview().inset(Metrics.votesStackTrailingIndent)
        }
    }
    
    func setupHeartButtonConstraints() {
        heartButton.snp.makeConstraints { make in
            make.width.equalTo(Metrics.heartButtonWidth)
            make.height.equalTo(Metrics.heartButtonHeight)
        }
    }
    
    func setupRadioTitleStackViewConstraints() {
        radioTitleStackView.snp.makeConstraints { make in
            make.top.equalTo(playImageView.snp.bottom)
            make.leading.trailing.equalTo(22.0).priority(.low)
            make.centerX.equalTo(containerView.snp.centerX)
            make.bottom.equalToSuperview().inset(19)
        }
    }
    
    func setupRadioSpacerViewConstraints() {
        radioSpacerView.snp.makeConstraints { make in
            make.width.equalTo(14.0).priority(.low)
            make.height.equalTo(14.0)
        }
    }
}

// MARK: - Metrics
fileprivate struct Metrics {
    /// play image
    static let playImageTopIndent: CGFloat = 13.0
    static let playImageLeadingIndent: CGFloat = 15.0
    
    /// votes stack
    static let votesStackTopIndent: CGFloat = 16.0
    static let votesStackTrailingIndent: CGFloat = 14.0
    
    /// heart button
    static let heartButtonWidth: CGFloat = 14.66
    static let heartButtonHeight: CGFloat = 12.0
    
    private init() {}
}
