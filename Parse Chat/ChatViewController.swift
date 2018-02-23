//
//  ChatViewController.swift
//  Parse Chat
//
//  Created by Hye Lim Joun on 2/21/18.
//  Copyright © 2018 hyelim. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource {
  
  @IBOutlet weak var tableView: UITableView! {
    didSet {
      tableView.rowHeight = UITableViewAutomaticDimension
      tableView.estimatedRowHeight = 50
    }
  }
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
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
    return cell
  }
}
