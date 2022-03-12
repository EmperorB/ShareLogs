//
//  ViewController.swift
//  ShareLogs
//
//  Created by Rajesh Budhiraja on 11/03/22.
//

import UIKit
import ShareCrashes

class ViewController: UIViewController {
    
    let existingCrashes = ShareCrash.shared.fetchCrashes()
    let tableView: UITableView = UITableView(frame: .zero, style: .grouped)
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        self.view.topAnchor.constraint(equalTo: tableView.topAnchor).isActive = true
        self.view.bottomAnchor.constraint(equalTo: tableView.bottomAnchor).isActive = true
        self.view.leadingAnchor.constraint(equalTo: tableView.leadingAnchor).isActive = true
        self.view.trailingAnchor.constraint(equalTo: tableView.trailingAnchor).isActive = true
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        existingCrashes.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = .init(frame: .zero)
        cell.textLabel?.text = existingCrashes[indexPath.section].stackTrace
        return cell
    }
    
    
}

