//
//  KeyChainErrors.swift
//  KeyChainSample
//
//  Created by cranoo on 2024/03/21.
//

import Foundation

enum KeyChainErrors: Error {
    case duplicateEntry
    case itemNotFound
    case unknown(OSStatus)
    
    var message: String {
        switch self {
        case .duplicateEntry:
            return "Accountが重複しています"
        case .itemNotFound:
            return "アイテムが存在しません"
        case .unknown(let status):
            return "不明なエラー(ステータスコード: \(status))"
        }
    }
}
