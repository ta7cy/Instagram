//
//  LoginViewController.swift
//  Instagram
//
//  Created by tanahashishinhichi on 2017/08/06.
//  Copyright © 2017年 ta7cy. All rights reserved.
//


import UIKit
import Firebase
import FirebaseAuth
import SVProgressHUD

class LoginViewController: UIViewController {

    @IBOutlet weak var mailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var displayNameTextField: UITextField!
    
    @IBAction func handleLoginButton(_ sender: Any) {
        
        if let address = mailAddressTextField.text, let password = passwordTextField.text{
        
            //アドレスとパスワードのいずれかでも入力されていない時は何もしない
            if address.characters.isEmpty || password.characters.isEmpty {
                print("DEBUG_PRINT: 何かが空文字です。")
                return
            }
            
            SVProgressHUD.show()
            
            
            Auth.auth().signIn(withEmail: address, password: password) { user, error in
                if let error = error{
                    print("DEBUG_PRINT: " + error.localizedDescription)
                    return
                } else {
                    print("DEBUG_PRINT: ログインに成功しました。")
                    
                    SVProgressHUD.dismiss()
                    
                    // 画面を閉じてViewControllerに戻る
                    self.dismiss(animated: true, completion: nil)
                    
                }
            
            }
        
        
        }
        
    }
    
    @IBAction func handleCreateAcountButton(_ sender: Any) {
        
        if let address = mailAddressTextField.text, let password = passwordTextField.text, let displayName = displayNameTextField.text {
        
            if address.characters.isEmpty || password.characters.isEmpty || displayName.characters.isEmpty {
                print("DEBUG_PRINT: 何かが空文字です。")
                return
                //いずれが空の場合は何もしない
                
            }
            
            SVProgressHUD.show()
            
            Auth.auth().createUser(withEmail: address, password: password){ user, error in
                if let error = error {
                    print("DEBUG_PRINT1:" + error.localizedDescription)
                    return
                }
                print("DEBUG_PRINT: ユーザー作成に成功しました。")
                
                //表示名の設定
                let user = Auth.auth().currentUser
                if let user = user{
                    let changeRequest = user.createProfileChangeRequest()
                    changeRequest.displayName = displayName
                    changeRequest.commitChanges{ error in
                        if let error = error {
                            print("DEBUG_PRINT2:" + error.localizedDescription)
                        }
                        print("DEBUG_PRINT: [displayName = \(user.displayName!)]の設定に成功しました。")
                        
                        SVProgressHUD.dismiss()
                        
                        //画面を閉じる
                        self.dismiss(animated: true, completion: nil)
                        
                    }
        
                }else{
                    print("DEBUG_PRINT: displayNameの設定に失敗しました。")
                
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
