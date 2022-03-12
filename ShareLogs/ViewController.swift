//
//  ViewController.swift
//  ShareLogs
//
//  Created by Rajesh Budhiraja on 11/03/22.
//

import UIKit
import ShareCrashes

class ViewController: UIViewController {
    
    private let existingCrashes = ShareCrash.shared.fetchCrashes()
    private let tableView: UITableView = UITableView(frame: .zero, style: .grouped)
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm dd-MMM-YYYY"
        return formatter
    }()
    
    private func setupView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DescriptionTableViewCell.self, forCellReuseIdentifier: "cell")
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? DescriptionTableViewCell else {
            return UITableViewCell()
        }
        let date = existingCrashes[indexPath.section].date ?? Date()
        cell.date.text = dateFormatter.string(from: date)
        cell.stack.text = existingCrashes[indexPath.section].stackTrace
        return cell
    }
}

class DescriptionTableViewCell: UITableViewCell {

    let date: UILabel = {
        let label = UILabel()
        label.text = "Date"
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let stack: UILabel = {
        let label = UILabel()
        label.text = "Stack"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createView() {
        self.contentView.addSubview(date)
        self.contentView.addSubview(stack)
        date.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        date.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        date.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 8).isActive = true
        date.bottomAnchor.constraint(equalTo: stack.topAnchor,  constant: -8).isActive = true
        stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 8).isActive = true
        stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
    }
}
