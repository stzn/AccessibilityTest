//
//  HomeworkViewController.swift
//  AccessibilityTest
//
//  Created by stakata on 2018/06/28.
//  Copyright © 2018年 shiz. All rights reserved.
//

import UIKit

final class HomeworkViewController: UIViewController {

    var works: [Homework] = HomeworkDatasource.homeworks()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 120.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// MARK: UITableViewDataSource
extension HomeworkViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return works.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeworkCell.identifier, for: indexPath) as? HomeworkCell else {
            fatalError("Invalid Cell")
        }
        
        cell.homework = works[indexPath.row]
        
        return cell
    }
}

// MARK: UITableViewDelegate
extension HomeworkViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)

        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard
            let nv = navigationController,
            let vc = sb.instantiateViewController(withIdentifier: TodoAfterViewController.identifier) as? TodoAfterViewController else {
            return
        }
        vc.viewModel = TodoViewModel(homework: works[indexPath.row])
        nv.pushViewController(vc, animated: true)
    }
}
