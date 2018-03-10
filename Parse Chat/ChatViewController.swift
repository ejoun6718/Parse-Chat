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
  
  var messages = [PFObject]()
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var chatMessageField: UITextField!
  
  @IBAction func onSend(_ sender: Any) {
    let chatMessage = PFObject(className: "Message")
    chatMessage["text"] = chatMessageField.text ?? ""
    chatMessage["user"] = PFUser.current()
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
    tableView.dataSource = self
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 50
    
    Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.refresh), userInfo: nil, repeats: true)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return messages.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
    cell.selectionStyle = .none
    
    cell.messageLabel.text = messages[indexPath.row]["text"] as? String
    
    if let user = messages[indexPath.row]["user"] as? PFUser {
      // User found! update username label with username
      cell.usernameLabel.text = user.username
    } else {
      // No user found, set default username
      cell.usernameLabel.text = "🤖"
    }
    
    return cell
  }
  
  @objc func refresh() {
    let query = PFQuery(className: "Message")
    query.includeKey("user")
    query.addDescendingOrder("createdAt")
    
    query.findObjectsInBackground (block: { (responses: [PFObject]?, error: Error?) -> Void in
      if let responses = responses {
        self.messages = responses
        self.tableView.reloadData()
        
      } else {
        print (error?.localizedDescription ?? "Error fetching messages")
      }
    })
  }
}
