//
//  KeyChainHelper.swift
//  KeyChainSample
//
//  Created by cranoo on 2024/03/20.
//

import Foundation

final class KeyChainHelper {
    // 保存
    static func save(service: String, account: String, password: Data) throws {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrGeneric: service,
            kSecAttrAccount: account,
            kSecValueData: password
        ] as CFDictionary
        
        let status = SecItemAdd(query, nil)
        
        // 重複している場合はエラー
        guard status != errSecDuplicateItem else {
            throw KeyChainError.duplicateEntry
        }
        // その他保存処理が失敗した場合はエラー
        guard status == errSecSuccess else {
            throw KeyChainError.unknown(status)
        }
    }
    
    // 取得
    static func get(service: String, account: String) throws -> Data? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrGeneric: service,
            kSecAttrAccount: account,
            kSecReturnData: true,
            kSecMatchLimit: kSecMatchLimitOne
        ] as CFDictionary
        
        // 検索した結果を返す
        var result: AnyObject?
        let status = SecItemCopyMatching(query, &result)
        
        // FIXME: デバッグ用
        print("KeyChainHelper.get status: \(status)")
        
        // 取得する対象が存在しない場合
        guard status != errSecItemNotFound else {
            throw KeyChainError.itemNotFound
        }
        
        // その他エラー
        guard status == errSecSuccess else {
            throw KeyChainError.unknown(status)
        }
        
        return result as? Data
    }
    
    // 削除
    static func delete(service: String, account: String) throws {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrGeneric: service,
            kSecAttrAccount: account
        ] as CFDictionary
        
        let status = SecItemDelete(query)
        
        // 取得する対象が存在しない場合
        guard status != errSecItemNotFound else {
            throw KeyChainError.itemNotFound
        }
        
        // その他エラー
        guard status == errSecSuccess else {
            throw KeyChainError.unknown(status)
        }
    }
}