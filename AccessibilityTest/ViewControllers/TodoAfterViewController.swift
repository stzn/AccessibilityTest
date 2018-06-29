//
//  DiaryDetailViewController.swift
//  AccessibilityTest
//
//  Created by stakata on 2018/06/26.
//  Copyright © 2018年 shiz. All rights reserved.
//

import UIKit

class TodoAfterViewController: UIViewController {
    
    static let identifier = "todoafter"

    var viewModel: TodoViewModel!

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var homeworkImage: UIImageView!
    @IBOutlet weak var homeworkTitle: UILabel!
    @IBOutlet weak var onTrackButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        
        setupViews()
        setupTableView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        guard let nv = navigationController,
            let vc = nv.viewControllers.last as? HomeworkViewController,
            let index = vc.works.index(where:{$0.id == viewModel.homework.id}) else {
                return
        }
        vc.works[index] = viewModel.homework
        nv.isNavigationBarHidden = false
    }
}

// MARK: Actions
extension TodoAfterViewController {
    @IBAction func onTrackTapped(_ sender: UIButton) {
        viewModel.homework.toggleIsOnTrack()
        setOnTrackButton()
    }
    
    @IBAction func backTapped(_ sender: UIButton) {
        guard let nv = navigationController else {
            return
        }
        nv.popViewController(animated: true)
    }
}


// MARK: setupView & Accessibility
extension TodoAfterViewController {
    
    override func accessibilityScroll(_ direction: UIAccessibilityScrollDirection) -> Bool {
        if direction == .right {
            guard let nv = navigationController else {
                return false
            }
            nv.popViewController(animated: true)
            return true
        }
        return true
    }

    private func setupViews() {
        homeworkImage.image = UIImage(named: viewModel.homework.imageUrl)
        homeworkTitle.text = viewModel.homework.title
        setBackButton()
        setOnTrackButton()
    }

    private func setBackButton() {
        backButton.titleLabel?.adjustsFontForContentSizeCategory = true
        backButton.accessibilityLabel = "戻る"
        backButton.accessibilityTraits = UIAccessibilityTraitButton
    }
    
    private func setOnTrackButton() {
        if viewModel.homework.isOnTrack {
            onTrackButton.setTitle("😆", for: .normal)
            onTrackButton.accessibilityLabel = "順調"
            onTrackButton.accessibilityTraits = UIAccessibilityTraitButton
        } else {
            onTrackButton.setTitle("😇", for: .normal)
            onTrackButton.accessibilityLabel = "遅れている"
            onTrackButton.accessibilityTraits = UIAccessibilityTraitButton
        }
        onTrackButton.accessibilityHint = "ボタンを押すと順調か遅れているかを切り替えます"
        
        // ボタンのタイトルはコードで設定するしか場所がない？？？
        onTrackButton.titleLabel?.adjustsFontForContentSizeCategory = true
    }
    
    private func setupTableView() {
        tableView.estimatedRowHeight = 200.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.dataSource = self
    }
    
}

// MARK: UITableViewDatasource
extension TodoAfterViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoAfterCell.identifier, for: indexPath) as? TodoAfterCell else {
            fatalError("Invalid Cell")
        }
        cell.tag = indexPath.row
        cell.delegate = self
        cell.todo = viewModel.itemFor(indexPath.row)
        return cell
    }
}

// MARK: UITableViewDelegate
extension TodoAfterViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        viewModel.selectItem(indexPath.row)
        
        guard let cell = tableView.cellForRow(at: indexPath) as? TodoAfterCell else {
            fatalError("invalid cell")
        }
        cell.shouldStrikeThroughString(viewModel.getState(indexPath.row))
    }
}


// MARK: TodoAfterCellDelegate
extension TodoAfterViewController: TodoAfterCellDelegate {
    func checkTapped(tag: Int) {
        guard let cell = tableView.cellForRow(at: IndexPath(row: tag, section: 0)) as? TodoAfterCell else {
            return
        }
        viewModel.homework.todos[tag].toggleIsCompleted()
        cell.shouldStrikeThroughString(!cell.checkButton.isSelected)
    }
}

