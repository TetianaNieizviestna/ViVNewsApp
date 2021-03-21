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
        
        let items: [NewsTableViewCell.Props]
        static let initial: Props = .init(state: .initial, selectedTab: .emailed, items: [])
    }
}

final class NewsViewController: UIViewController {
    var viewModel: NewsViewModelType!
    var props: Props = .initial
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var segmentedControl: UISegmentedControl!
    @IBOutlet private var tableView: UITableView!
    var refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        viewModel.didStateChanged = { [weak self] props in
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
        segmentedControl.addTarget(self, action: #selector(segmentIndexChanged), for: .valueChanged)
    }
    
    @objc
    private func segmentIndexChanged() {
        viewModel.selectSegmentTab(index: segmentedControl.selectedSegmentIndex)
    }
    
    private func setupTableView() {
        tableView.setDataSource(self, delegate: self)
        tableView.register([NewsTableViewCell.identifier])
        tableView.tableFooterView = UIView(frame: .zero)

        refreshControl.attributedTitle = NSAttributedString(string: "Loading...")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        viewModel.refresh()
    }
    
    func render(_ props: Props) {
        self.props = props

        switch props.state {
        case .initial:
            view.stopHud()
        case .loading:
            view.startHud()
        case .loaded:
            refreshControl.endRefreshing()
            view.stopHud()
        case .failed(let error):
            refreshControl.endRefreshing()
            view.stopHud()
            showAlert(title: "Error", message: error)
        }
        segmentedControl.selectedSegmentIndex = props.selectedTab.rawValue
        self.tableView.reloadData()
    }
}

extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        props.items[indexPath.row].onSelect.perform()
    }
}

extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return props.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier) as? NewsTableViewCell else { return UITableViewCell() }
        cell.render(props.items[indexPath.row])
        return cell
    }
    
    
}
