//
//  FavoritesController.swift
//  RadioApp
//
//  Created by Natalia on 30.07.2024.
//

import UIKit

private typealias RadioCell = TableCell<FavoriteRadioView>

final class FavoritesController: ViewController {

    private let presenter: FavoritesPresenterProtocol
    
    private var items = [FavStationModel]()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Favorites".localized
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
    
    init(presenter: FavoritesPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.activate()
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
        let items: [FavStationModel]
    }
    
    func update(with model: Model) {
        items = model.items
        tableView.reloadData()
    }
}

extension FavoritesController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        items[indexPath.row].didSelectHandler()
    }
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
                favoriteHandler: { [weak self] in
                    model.favoriteHandler()
                    self?.items.remove(at: indexPath.row)
                    self?.tableView.reloadData()
                    
//                    self?.items.remove(at: indexPath.row)
//                    self?.tableView.deleteRows(at: [indexPath], with: .automatic)
                },
                didSelectHandler: model.didSelectHandler
            ),
            insets: .init(top: 0, left: 0, bottom: 20, right: 0)
        )
        cell.selectionStyle = .none
        return cell
    }
    
    
}
