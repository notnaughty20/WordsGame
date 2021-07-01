//
//  ViewController.swift
//  WordsGame
//
//  Created by Влад Мади on 30.04.2021.
//

import UIKit

protocol StartViewControllerDelegate {
    func toggleMenu()
}

class StartViewController: UIViewController {

    @IBOutlet weak var wordTextField: UITextField!
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    
    var words = ["Магнитотерапия",
                 "Рекогносцировка",
                 "Энциклопедия"]
    
    var delegate: StartViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        
        view.addGestureRecognizer(tap)
        choiseInputView()
        
        wordTextField.text = words[Int.random(in: 0...words.count-1)]
    }
    
    func choiseInputView() {
        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        picker.backgroundColor = .white
        wordTextField.inputView = picker
   
    }
    
    @IBAction func menuAction(_ sender: UIButton) {
        
        delegate?.toggleMenu()
        
    }
    
    
    @IBAction func startAction(_ sender: UIButton) {
        
        guard wordTextField.text!.count > 7 else {
            let alert = UIAlertController(title: "Ошибочка!", message: "Минимальная длина слова - 8 букв", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(okAction)
            
            present(alert, animated: true, completion: nil)
            print("Слишком короткое слово")
            return
        }
        
        performSegue(withIdentifier: "fromStartToGame", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "fromStartToGame" {
            
            let vc = segue.destination as! GameViewController
            vc.bigWord = wordTextField.text!
            
            if firstTextField.text != "" {
                let user = User(name: firstTextField.text!)
                vc.firstUser = user
            } else {
                let user = User(name: "Игрок 1")
                vc.firstUser = user
            }
            
            if secondTextField.text != "" {
                vc.secondUser = User(name: secondTextField.text!)
            } else {
                vc.secondUser = User(name: "Игрок 2")
            }
        }
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
}

