//
//  SettingViewController.swift
//  Instagram
//
//  Created by tanahashishinhichi on 2017/08/06.
//  Copyright © 2017年 ta7cy. All rights reserved.
//

import UIKit
import ESTabBarController
import Firebase
import FirebaseAuth
import SVProgressHUD


class SettingViewController: UIViewController {

    @IBOutlet weak var displayNameTextField: UITextField!
    
    @IBAction func handleChangeButton(_ sender: Any) {
        
        if let displayName = displayNameTextField.text{
            
            if displayName.characters.isEmpty{
                SVProgressHUD.showError(withStatus: "表示名を入力してください")
                return
            }
            
            let user = Auth.auth().currentUser
            if let user = user {
                let changeRequest = user.createProfileChangeRequest()
                changeRequest.displayName = displayName
                changeRequest.commitChanges { error in
                    if let error = error {
                        print("DEBUG_PRINT: " + error.localizedDescription)
                    }
                    print("DEBUG_PRINT: [displayName = \(user.displayName!)]の設定に成功しました。")
                    
                    // HUDで完了を知らせる
                    SVProgressHUD.showSuccess(withStatus: "表示名を変更しました")
                }
            }else{
                print("DEBUG_PRINT: displayNameの設定に失敗しました。")
            }
            
        }
        // キーボードを閉じる
        self.view.endEditing(true)
        
    }

    @IBAction func handleLogoutButton(_ sender: Any) {
        
        try! Auth.auth().signOut()
        
        let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "Login")
        self.present(loginViewController!, animated: true, completion: nil)
        
        let tabBarController = parent as! ESTabBarController
        tabBarController.setSelectedIndex(0, animated: false)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let user = Auth.auth().currentUser
        if let user = user{
        
            displayNameTextField.text = user.displayName
        
        }
    }
}
