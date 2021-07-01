//
//  GameViewController.swift
//  WordsGame
//
//  Created by Влад Мади on 30.04.2021.
//

import UIKit

class GameViewController: UIViewController {
    
    var bigWord = "Магнитотерапия"
    var firstUser = User(name: "")
    var secondUser = User(name: "")
    
    var isFirstUser = true
    var words = [String]()
    
    @IBOutlet weak var bigWordLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    
    @IBOutlet weak var firstScoreLabel: UILabel!
    @IBOutlet weak var secondScoreLabel: UILabel!
    @IBOutlet weak var secondNameLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    
    @IBOutlet weak var inputTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bigWordLabel.text = bigWord
        firstNameLabel.text = firstUser.name
        secondNameLabel.text = secondUser.name
        firstScoreLabel.text = "0"
        secondScoreLabel.text = "0"
        firstView.layer.borderWidth = 5
        firstView.layer.borderColor = #colorLiteral(red: 0.04867798835, green: 0.4060755372, blue: 1, alpha: 1)
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func wordToChars(word: String) -> [Character] {
        
        var chars = [Character]()
        for char in word.lowercased() {
            chars.append(char)
        }
        return chars
    }
    
    private func checkWord(word: String) -> Int {
        
        guard !(words.contains(word.lowercased())) else {
            print("Это слово уже было составлено ранее")
            return 0
        }
        
        var strChars = wordToChars(word: bigWord)
        let wordChars = wordToChars(word: word)

        var result = ""

        for char in wordChars {
            
            if strChars.contains(char) {
                result.append(char)
                
                var i = 0
                while strChars[i] != char {
                    i += 1
                }
                strChars.remove(at: i)
                
            } else {
                print("Данное слово не может быть составлено")
                result = ""
                break
            }
        }

        if result.count > 1 {
            words.append(result)
            if isFirstUser {
                print("first: \(result.count)")
                firstUser.score += result.count
                firstScoreLabel.text = String(firstUser.score)
                
                firstView.layer.borderWidth = 0
                secondView.layer.borderWidth = 5
                secondView.layer.borderColor = #colorLiteral(red: 0.04867798835, green: 0.4060755372, blue: 1, alpha: 1)
                
            } else {
                print("second: \(result.count)")
                secondUser.score += result.count
                secondScoreLabel.text = String(secondUser.score)
                
                secondView.layer.borderWidth = 0
                firstView.layer.borderWidth = 5
                firstView.layer.borderColor = #colorLiteral(red: 0.04867798835, green: 0.4060755372, blue: 1, alpha: 1)
            }
            isFirstUser = !isFirstUser
        }

        inputTextField.text = ""
        
        tableView.reloadData()
        return result.count
    }
    
    @IBAction func checkAction(_ sender: UIButton) {
        
        guard let text = inputTextField.text else {
            return
        }
        
        print(checkWord(word: text))
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Вы уверены?", message: "Вы точно хотите покинуть игру?", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Да", style: .destructive) { _ in
            self.dismiss(animated: true, completion: nil)
        }
        
        let noAction = UIAlertAction(title: "Нет", style: .cancel, handler: nil)
        
        alert.addAction(yesAction)
        alert.addAction(noAction)
        
        present(alert, animated: true, completion: nil)
        
    }

}

extension GameViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell")
        cell?.textLabel?.text = words[indexPath.row]
        cell?.detailTextLabel?.text = String(words[indexPath.row].count)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(indexPath.row)
        print(words[indexPath.row])
    }
    
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//
//        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { _, _, completion in
//            self.words.remove(at: indexPath.row)
//            tableView.reloadData()
//            completion(true)
//        }
//        return UISwipeActionsConfiguration(actions: [deleteAction])
//    }
    
    
}
