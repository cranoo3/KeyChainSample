//
//  ContentViewModelError.swift
//  KeyChainSample
//
//  Created by cranoo on 2024/03/23.
//

import Foundation

enum ContentViewModelError: Error {
    case FailedToConvertPassword
}

extension ContentViewModelError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .FailedToConvertPassword:
            return "パスワードの変換に失敗しました"
        }
    }
}
