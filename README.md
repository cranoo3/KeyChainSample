## このアプリはどんなアプリ？
KeyChainへパスワードを保存するサンプルプロジェクトです

## KeyChainとは？
- Appleが提供するパスワード管理システムです
- iOS、macOS、watchOS、tvOSなどのAppleプラットフォーム上で、パスワード、クレジットカード情報、APIキーなどの秘密鍵を安全に保存することができます。(by Gemini)

## KeyChainHelperクラス
- このアプリのメインは[`KeyChainHelper`](./KeyChainSample/Model/KeyChainHelper.swift)クラスです
  > 24行目や28行目の`throw KeyChainError.xxxxx`の部分だけ適切に変更すればコピペで使用できます
  > 
  > もしくは[`KeyChainErrors.swift`](./KeyChainSample/Model/KeyChainErrors.swift)のenumもコピーすれば修正なしで使えます

## 開発環境について
| 環境           | バージョン          |
| ------------- | ---------------- |
| IDE           | Xcode 15.1       |
| Swift         | Swift 5.9        |
| Framework     | SwiftUI          |
| ターゲットOS    | iOS17.0          |

## 参考にしたサイト等
- [iOS | KeyChain への保存、読込、削除処理を実装する](https://zenn.dev/u_dai/articles/c90b3c62ef2251)
- [iOSのキーチェーンについて - Qiita](https://qiita.com/sachiko-kame/items/261d42c57207e4b7002a)
