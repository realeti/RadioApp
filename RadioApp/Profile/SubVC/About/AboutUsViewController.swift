//
//  AboutUsViewController.swift
//  RadioApp
//
//  Created by Иван Семенов on 31.07.2024.
//

import UIKit
import SafariServices

final class AboutUsViewController: ViewController, AboutViewControllerProtocol {
    
    var presenter: AboutUsPresenterProtocol!
    
    let collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TeamViewCell.self, forCellWithReuseIdentifier: "TeamViewCell")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    //MARK: - Lyfe cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    //MARK: - Private Methods
    private func setViews() {
        view.backgroundColor = .darkBlueApp
        view.addSubview(collection)
        collection.dataSource = self
        collection.delegate = self
        title = "Team".localized
        collection.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.leading.trailing.equalToSuperview()
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
extension AboutUsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Team.team.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "TeamViewCell",
            for: indexPath
        ) as? TeamViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: Team.team[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let url = Team.team[indexPath.row].gitHub
        if let url = URL(string: url) {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: view.frame.width - 20, height: 80)
    }
}
