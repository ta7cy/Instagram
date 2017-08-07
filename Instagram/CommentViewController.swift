//
//  CommentViewController.swift
//  Instagram
//
//  Created by tanahashishinhichi on 2017/08/06.
//  Copyright © 2017年 ta7cy. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class CommentViewController: UIViewController {
    
    
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var postLabel: UILabel!
    
    var postData: PostData? = nil


    @IBAction func handleComeButton(_ sender: Any) {
    
        //self.dismiss(animated: false, completion: nil)
 
    }

    @IBAction func handleCommentButton(_ sender: Any) {

        print("DEBUG_COMMET: 投稿ボタンが押されました")

        let postRef = Database.database().reference().child(Const.PostPath).child((postData?.id)!)
        let name = Auth.auth().currentUser?.displayName
        let text: String = name! + "：" + commentTextField.text!
        
        postData?.comments.append(text)
        postData?.commentUsers.append(name!)
        
        let comments = ["comments":postData?.comments]
        let commentUsers = ["commentUsers":postData?.commentUsers]
        postRef.updateChildValues(comments)
        postRef.updateChildValues(commentUsers)
        

        
        self.dismiss(animated: false, completion: nil)
    }
    
    
    @IBAction func handleCancelButton(_ sender: Any) {
        
        
        print("DEBUG_COMMET: キャンセルボタンが押されました")
        self.dismiss(animated: false, completion: nil)
    }
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        postLabel.text = (postData?.name)! + ":" + (postData?.caption)!
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
