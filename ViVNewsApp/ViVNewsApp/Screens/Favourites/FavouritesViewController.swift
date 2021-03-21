//
//  FavouritesViewController.swift
//  ViVNewsApp
//
//  Created by Tetiana Nieizviestna on 19.03.2021.
//

import UIKit

extension FavouritesViewController {
    struct Props {
        
        let state: ScreenState; enum ScreenState {
            case initial
            case loading
            case loaded
            case failed(String)
        }
                
        let items: [NewsTableViewCell.Props]
        static let initial: Props = .init(state: .initial, items: [])
    }
}

final class FavouritesViewController: UIViewController {
    var viewModel: FavouritesViewModelType!
    var props: Props = .initial

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        viewModel.didStateChanged = { [weak self] props in
            self?.render(props)
        }

    }
    
    private func setupUI() {
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.setDataSource(self, delegate: self)
        tableView.register([NewsTableViewCell.identifier])
        tableView.tableFooterView = UIView(frame: .zero)
    }

    func render(_ props: Props) {
        self.props = props

        switch props.state {
        case .initial:
            view.stopHud()
        case .loading:
            view.startHud()
        case .loaded:
            view.stopHud()
        case .failed(let error):
            view.stopHud()
            showAlert(title: "Error", message: error)
        }
        self.tableView.reloadData()
    }
}

extension FavouritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        props.items[indexPath.row].onSelect.perform()
    }
}

extension FavouritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return props.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier) as? NewsTableViewCell else { return UITableViewCell() }
        cell.render(props.items[indexPath.row])
        return cell
    }
}
