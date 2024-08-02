//
//  FavoritesController.swift
//  RadioApp
//
//  Created by Natalia on 30.07.2024.
//

import UIKit

private typealias RadioCell = TableCell<FavoriteRadioView>

class FavoritesController: ViewController {

    var presenter: FavoritesPresenterProtocol?
    
    private var items = [FavoriteRadioView.Model]()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Favorites"
        label.textColor = .white
        label.font = .systemFont(ofSize: 30, weight: .light)
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RadioCell.self, forCellReuseIdentifier: String(describing: RadioCell.self))
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        presenter?.activate()
        
    }
    
    private func setupView() {
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(25)
            $0.leading.equalToSuperview().inset(63)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(25)
            $0.leading.trailing.bottom.equalToSuperview().inset(61)
        }
    }

}

extension FavoritesController: FavoritesControllerProtocol {
    struct Model {
        let items: [FavoritesModel]
    }
    
    func update(with model: Model) {
        items = model.items
//        emptyView.isHidden = !items.isEmpty
//        tableView.isHidden = items.isEmpty
        tableView.reloadData()
    }
    
    
}

extension FavoritesController: UITableViewDelegate {
    
}

extension FavoritesController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard 
            let cell = tableView.dequeueReusableCell(
                withIdentifier: String(describing: RadioCell.self),
                for: indexPath
            ) as? RadioCell
        else { return UITableViewCell() }
        
        let model = items[indexPath.row]
        
        cell.update(
            with: .init(
                radioTitle: model.radioTitle,
                genre: model.genre,
                favoriteHandler: model.favoriteHandler,
                didSelectHandler: model.didSelectHandler
            ),
            insets: .init(top: 0, left: 0, bottom: 20, right: 0)
        )
        return cell
    }
    
    
}
