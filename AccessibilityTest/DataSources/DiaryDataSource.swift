//
//  DiaryDataSource.swift
//  AccessibilityTest
//
//  Created by stakata on 2018/06/25.
//  Copyright © 2018年 shiz. All rights reserved.
//

import Foundation

struct DiaryDataSource {

    static func diaries() -> [Diary] {
        let diaryList = [
            Diary(id: 1, userId: 1, date: "8月4日", weather: "user",
                  content: """
                        きょうはどうぶつえんにいきました。
                        てれびのよりもぱんたがおおきくてとてもかわいかったです。
                        あとさるのまえでたべたアイスクリームもおいしかったです。
                        でもぞうはこわかったです。
                        こんどはおじいちゃんともいきたいな。
                        """,
                  imageUrl: "animals"),
        ]
        return diaryList
    }
}
