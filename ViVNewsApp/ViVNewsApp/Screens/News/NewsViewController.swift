//
//  NewsViewController.swift
//  ViVNewsApp
//
//  Created by Tetiana Nieizviestna on 19.03.2021.
//

import UIKit

extension NewsViewController {
    struct Props {
        
        let state: ScreenState; enum ScreenState {
            case initial
            case loading
            case loaded
            case failed(String)
        }
        
        let selectedTab: NewsSegmentTab
        
        let items: [Item]; enum Item {
            case emailed(NewsTableViewCell.Props)
            case shared(NewsTableViewCell.Props)
            case viewed(NewsTableViewCell.Props)
        }
        static let initial: Props = .init(state: .initial, selectedTab: .emailed, items: [])
    }
}

final class NewsViewController: UIViewController {
    var viewModel: NewsViewModelType!
    var props: Props = .initial
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var segmentedControl: UISegmentedControl!
    @IBOutlet private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        viewModel.didLoadData = { [weak self] props in
            DispatchQueue.main.async {
                self?.render(props)
            }
        }
    }
    
    private func setupUI() {
        setupSegmentedControl()
        setupTableView()
    }
    
    private func setupSegmentedControl() {
        let textAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor: Style.Color.segmentText        ]
            
        segmentedControl.setTitleTextAttributes(textAttributes, for: .selected)
        segmentedControl.setTitleTextAttributes(textAttributes, for: .normal)
        segmentedControl.selectedSegmentTintColor = Style.Color.segmentBg
        segmentedControl.backgroundColor = Style.Color.segmentBgSelected
    }
    
    private func setupTableView() {
        tableView.setDataSource(self, delegate: self)
        tableView.register([NewsTableViewCell.identifier])
    }
    
    func render(_ props: Props) {
        self.props = props

        switch props.state {
        case .initial:
            break
        case .loading:
            break
        case .loaded:
            break
        case .failed(let error):
            showAlert(title: "Error", message: error)
        }
        segmentedControl.selectedSegmentIndex = props.selectedTab.rawValue
        self.tableView.reloadData()
    }
}

extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch props.items[indexPath.row] {
        case .emailed(let cellProps):
            cellProps.onSelect.perform()
        case .shared(let cellProps):
            cellProps.onSelect.perform()
        case .viewed(let cellProps):
            cellProps.onSelect.perform()
        }
    }
}

extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return props.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch props.items[indexPath.row] {
        case .emailed(let cellProps):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier) as? NewsTableViewCell else { return UITableViewCell() }
            cell.render(cellProps)
            return cell
        case .shared(let cellProps):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier) as? NewsTableViewCell else { return UITableViewCell() }
            cell.render(cellProps)
            return cell
        case .viewed(let cellProps):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier) as? NewsTableViewCell else { return UITableViewCell() }
            cell.render(cellProps)
            return cell
        }
    }
    
    
}
