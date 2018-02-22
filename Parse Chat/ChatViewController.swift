//
//  ChatViewController.swift
//  Parse Chat
//
//  Created by Hye Lim Joun on 2/21/18.
//  Copyright © 2018 hyelim. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController {
  
  @IBOutlet weak var chatMessageField: UITextField!
  @IBAction func onSend(_ sender: Any) {
    let chatMessage = PFObject(className: "Message")
    chatMessage["text"] = chatMessageField.text ?? ""
    chatMessage.saveInBackground { (success, error) in
      if success {
        print("The message was saved!")
      } else if let error = error {
        print("Problem saving message: \(error.localizedDescription)")
      }
      self.chatMessageField.text = ""
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}
