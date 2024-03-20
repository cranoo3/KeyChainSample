//
//  ContentView.swift
//  KeyChainSample
//
//  Created by cranoo on 2024/03/20.
//

import SwiftUI

struct ContentView: View {
    @FocusState var isFocused
    @State var viewModel = ContentViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("サービス名")
                    .font(.title3)
                    .fontWeight(.bold)
                TextField("Service", text: $viewModel.service)
                    .textFieldStyle(.roundedBorder)
                    .focused($isFocused)
                    .onSubmit {
                        isFocused = false
                    }
                
                Divider()
                    .padding(.vertical)
                
                Text("保存・取得・削除")
                    .font(.title3)
                    .fontWeight(.bold)
                TextField("Account", text: $viewModel.account)
                    .textFieldStyle(.roundedBorder)
                    .focused($isFocused)
                    .onSubmit {
                        isFocused = false
                    }
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(.roundedBorder)
                    .focused($isFocused)
                    .onSubmit {
                        isFocused = false
                    }
                
                //　保存・取得・削除ボタン
                HStack {
                    Spacer()
                    
                    Button("保存") {
                        viewModel.save()
                    }
                    .disabled(viewModel.disableSaveButton())
                    
                    Spacer()
                    
                    Button("取得") {
                        viewModel.get()
                    }
                    .disabled(viewModel.disableDeleteButton())
                    
                    Spacer()
                    
                    Button(role: .destructive, action: viewModel.delete) {
                        Text("削除")
                    }
                    .disabled(viewModel.disableDeleteButton())
                    
                    Spacer()
                }
                
                Divider()
                    .padding(.vertical)
                
                Text("登録されているパスワード")
                    .font(.title3)
                    .fontWeight(.bold)
                Text(viewModel.userPassword)
                    .frame(maxWidth: .infinity)
                    .frame(alignment: .center)
            }
            .padding()
            .navigationTitle("KeyChainSample")
            .alert(viewModel.alertMessage, isPresented: $viewModel.isShowAlert) {
                Button("OK") { /*特段何も処理はない*/ }
            }
        }
    }
}

#Preview {
    ContentView()
}
