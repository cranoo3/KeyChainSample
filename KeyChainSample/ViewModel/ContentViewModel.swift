//
//  ContentViewModel.swift
//  KeyChainSample
//
//  Created by cranoo on 2024/03/20.
//

import Foundation

@Observable
final class ContentViewModel {
    // 保存する情報
    var service = ""
    var account = ""
    var password = ""
    
    // 取得したパスワード
    var userPassword = ""
    
    // エラー発生時にアラートを表示する為のフラグ
    var isShowAlert = false
    var alertMessage = ""
    
    // MARK: - 値を保存する
    func save() {
        // passwordをDataへ変換する
        guard let convertedPasswordString = password.data(using: .utf8) else {
            return
        }
        
        do {
            try KeyChainHelper.save(
                service: self.service,
                account: self.account,
                password: convertedPasswordString
            )
            
            showAlert(message: "保存成功")
            clearAccountAndPassword()
        } catch {
            // エラーを表示する
            showAlert(optionalError: error)
        }
    }
    
    // MARK: - 取得する
    func get() {
        do {
            guard let result = try KeyChainHelper.get(
                service: self.service,
                account: self.account
            ) else {
                return
            }
            
            guard let convertedResultString = String(data: result, encoding: .utf8) else {
                return
            }
            
            userPassword = convertedResultString
        } catch {
            showAlert(optionalError: error)
        }
    }
    
    // MARK: - 削除する
    func delete() {
        do {
            try KeyChainHelper.delete(
                service: self.service,
                account: self.account
            )
            
            showAlert(message: "削除成功")
            clearAccountAndPassword()
            userPassword = ""
        } catch {
            showAlert(optionalError: error)
        }
    }
    
    // MARK: - アラートを表示する
    func showAlert(message: String = "", optionalError: Error? = nil) {
        // アラートの表示フラグを最後に立てる
        defer {
            isShowAlert = true
        }
        alertMessage = message
        
        // エラー発生している場合
        guard let error = optionalError else {
            return
        }
        
        if let keyChainError = error as? KeyChainError {
            alertMessage = keyChainError.message
        } else {
            alertMessage = error.localizedDescription
        }
    }
    
    // MARK: - アカウントとパスワードのTextFieldをリセットする
    func clearAccountAndPassword() {
        account = ""
        password = ""
    }
    
    // MARK: - ボタン押せるか確認する
    // 登録ボタン
    func disableSaveButton() -> Bool {
        if service.isEmpty || account.isEmpty || password.isEmpty {
            return true
        } else {
            return false
        }
    }
    // 削除ボタン
    func disableDeleteButton() -> Bool {
        if service.isEmpty || account.isEmpty {
            return true
        } else {
            return false
        }
    }
}
