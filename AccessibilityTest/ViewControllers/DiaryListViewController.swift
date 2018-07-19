//
//  DiaryListViewController.swift
//  AccessibilityTest
//
//  Created by stakata on 2018/06/25.
//  Copyright © 2018年 shiz. All rights reserved.
//

import UIKit
import AVFoundation

final class DiaryListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var diaries = DiaryDataSource.diaries()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 200.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// MARK: UITableViewDatasource
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
        cell.delegate = self
        
        return cell
    }
}

// MARK: UITableViewDatasource
extension DiaryListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

// MARK: DiaryCellDelegate
extension DiaryListViewController: DiaryCellDelegate {
    func chatButtonTapped(_ tag: Int) {
        showCommentAlert()
    }
    
    private func showCommentAlert() {
        
        let alert = UIAlertController(title: "コメント", message: "", preferredStyle: .alert)
        alert.addTextField { field in
            field.placeholder = "入力してください"
            field.adjustsFontForContentSizeCategory = true
        }
        
        let ok = UIAlertAction(title: "登録", style: .default) { _ in
            
            guard let f = alert.textFields?.first,
                let text = f.text, !text.isEmpty else {
                return
            }
            let syntherizer = AVSpeechSynthesizer()
            let voice = AVSpeechSynthesisVoice(language: "ja-JP")
            let utterance = AVSpeechUtterance(string: "登録が完了しました。\(text)")
            utterance.voice = voice
            syntherizer.speak(utterance)
        }
        alert.addAction(ok)
        
        let cancel = UIAlertAction(title: "キャンセル", style: .destructive)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
}

