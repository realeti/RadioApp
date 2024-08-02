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
    
    private lazy var voteLabel: UILabel = {
        let label = UILabel()
        label.text = K.Popular.votes.rawValue + " "
        label.textColor = .white
        label.font = .systemFont(ofSize: 10.0, weight: .bold)
        return label
    }()
    
    private lazy var voteCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 10.0, weight: .bold)
        return label
    }()
    
    private lazy var voteButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(voteButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var radioTitleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var radioTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 30.0, weight: .bold)
        return label
    }()
    
    private lazy var radioSubtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 15.0, weight: .regular)
        return label
    }()
    
    private lazy var radioSpacerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var waveImageView: UIImageView = {
        let view = UIImageView()
        view.image = .wave.withTintColor(.white.withAlphaComponent(0.3))
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var leftWaveCircle: UIImageView = {
        let view = UIImageView()
        view.image = .waveCircle
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var rightWaveCircle: UIImageView = {
        let view = UIImageView()
        view.image = .waveCircle
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    // MARK: - Private Properties
    private var votes: Int = 0 {
        didSet {
            let votesText = "\(votes) "
            UIView.transition(with: voteCountLabel, duration: 0.3, options: .transitionCrossDissolve, animations: {
                self.voteCountLabel.text = votesText
            }, completion: nil)
        }
    }
    
    // MARK: - Public Properties
    weak var delegate: PopularViewProtocol?
    var indexPath: IndexPath?
    
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
                playImageView.isHidden = false
                containerView.layer.borderColor = nil
                containerView.backgroundColor = .pinkApp
                waveImageView.image = .wave.withTintColor(.white)
            } else {
                playImageView.isHidden = true
                containerView.backgroundColor = nil
                containerView.layer.borderColor = UIColor.stormyBlue.cgColor
                waveImageView.image = .wave.withTintColor(.white.withAlphaComponent(0.3))
            }
        }
    }
    
    // MARK: - Cell Life Cycle
    override func prepareForReuse() {
        super.prepareForReuse()
        
        voteCountLabel.text = nil
        radioTitleLabel.text = nil
        radioSubtitleLabel.text = nil
        leftWaveCircle.image = nil
        rightWaveCircle.image = nil
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
            radioTitleStackView,
            waveImageView
        )
        
        voteStackView.addArrangedSubviews(
            voteLabel,
            voteCountLabel,
            voteButton
        )
        
        radioTitleStackView.addArrangedSubviews(
            radioTitleLabel,
            radioSubtitleLabel
        )
        
        waveImageView.addSubviews(leftWaveCircle, rightWaveCircle)
    }
}

// MARK: - Configure Cell
extension PopularCollectionViewCell {
    func configure(with model: PopularViewModel, _ isStationVoted: Bool, and indexPath: IndexPath) {
        radioTitleLabel.text = model.title
        radioSubtitleLabel.text = model.subtitle
        
        votes = model.countVotes
        self.indexPath = indexPath
        
        setupVoteButton(isStationVoted)
        setupWaveCircles(with: indexPath)
    }
    
    // MARK: - Set VoteButton image
    private func setupVoteButton(_ isStationVoted: Bool) {
        let image: UIImage = isStationVoted ? .voteOn : .voteOff
        voteButton.setBackgroundImage(image, for: .normal)
    }
    
    // MARK: - Set WaveCircles image
    private func setupWaveCircles(with indexPath: IndexPath) {
        let colors: [UIColor] = [
            .darkPinkCircle,
            .blueCircle,
            .magentaCircle,
            .greenCircle,
            .yellowCircle,
            .orangeCircle
        ]
        
        let colorIndex = indexPath.row % colors.count
        let color = colors[colorIndex]
        
        leftWaveCircle.image = .waveCircle.withTintColor(color)
        rightWaveCircle.image = .waveCircle.withTintColor(color)
    }
}

// MARK: - Update Station Votes
extension PopularCollectionViewCell {
    func updateStationVotes(_ isStationVoted: Bool) {
        votes += isStationVoted ? 1 : -1
        
        let newImage: UIImage = isStationVoted ? .voteOn : .voteOff
        UIView.transition(with: voteButton, duration: 0.3, options: .transitionFlipFromLeft, animations: {
            self.voteButton.setBackgroundImage(newImage, for: .normal)
        }) { _ in
            self.voteButton.isUserInteractionEnabled = true
        }
    }
}

// MARK: - Actions
private extension PopularCollectionViewCell {
    @objc func voteButtonPressed(_ sender: UIButton) {
        voteButton.isUserInteractionEnabled = false
        delegate?.voteForStation(at: indexPath)
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
        setupWaveImageViewConstraints()
        setupWaveCirclesContraints()
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
        voteButton.snp.makeConstraints { make in
            make.width.height.equalTo(Metrics.heartButtonWidth)
        }
    }
    
    func setupRadioTitleStackViewConstraints() {
        radioTitleStackView.snp.makeConstraints { make in
            make.top.equalTo(playImageView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(Metrics.radioTitleStackIndent)
        }
    }
    
    func setupWaveImageViewConstraints() {
        waveImageView.snp.makeConstraints { make in
            make.top.equalTo(radioTitleStackView.snp.bottom).offset(Metrics.waveImageTopIndent)
            make.centerX.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.16)
            make.width.equalToSuperview().multipliedBy(0.67)
            make.bottom.equalToSuperview().inset(Metrics.waveImageBottomIndent)
        }
    }
    
    func setupWaveCirclesContraints() {
        leftWaveCircle.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Metrics.circleIndent)
            make.leading.equalToSuperview().inset(Metrics.circleIndent)
            make.width.height.equalTo(waveImageView.snp.height).multipliedBy(0.37)
        }
        
        rightWaveCircle.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Metrics.circleIndent)
            make.trailing.equalToSuperview()
            make.width.height.equalTo(leftWaveCircle)
        }
    }
}

// MARK: - Metrics
fileprivate struct Metrics {
    /// play image
    static let playImageTopIndent: CGFloat = 13.0
    static let playImageLeadingIndent: CGFloat = 16.0
    
    /// votes stack
    static let votesStackTopIndent: CGFloat = 16.0
    static let votesStackTrailingIndent: CGFloat = 14.0
    
    /// heart button
    static let heartButtonWidth: CGFloat = 14.66
    static let heartButtonHeight: CGFloat = 12.0
    
    /// radio title stack
    static let radioTitleStackIndent: CGFloat = 16.0
    
    /// wave image view
    static let waveImageTopIndent: CGFloat = 10.0
    static let waveImageBottomIndent: CGFloat = 15.0
    
    /// wave circle image view
    static let circleIndent: CGFloat = 2.0
    
    private init() {}
}
