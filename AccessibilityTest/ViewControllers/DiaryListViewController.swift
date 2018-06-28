//
//  DiaryListViewController.swift
//  AccessibilityTest
//
//  Created by stakata on 2018/06/25.
//  Copyright © 2018年 shiz. All rights reserved.
//

import UIKit

final class DiaryListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var diaries = DiaryDataSource.diaries()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 200.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.dataSource = self
    }
}

extension DiaryListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diaries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DiaryCell.identifier, for: indexPath) as? DiaryCell else {
            fatalError("Invalid Cell")
        }
        
        cell.diary = diaries[indexPath.row]
        
        return cell
    }
}
