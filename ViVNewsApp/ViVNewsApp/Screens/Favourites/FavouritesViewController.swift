//
//  FavouritesViewController.swift
//  ViVNewsApp
//
//  Created by Tetiana Nieizviestna on 19.03.2021.
//

import UIKit

extension FavouritesViewController {
    struct Props {
        let onRefresh: Command

        let items: [NewsTableViewCell.Props]
        static let initial: Props = .init(onRefresh: .nop, items: [])
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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        props.onRefresh.perform()
    }
    
    private func setupUI() {
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.setDataSource(self, delegate: self)
        tableView.register([NewsTableViewCell.identifier])
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.reloadData()
    }
    
    @objc func refresh(_ sender: AnyObject) {
        self.props.onRefresh.perform()
    }
    
    func render(_ props: Props) {
        self.props = props

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
