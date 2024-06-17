//
//  LogoQuizViewController.swift
//  LogoStarterProject
//
//  Created by Raj Shekhar on 17/06/24.
//

import UIKit

class LogoQuizViewController: UIViewController {
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var letterStackView: UIStackView!
    @IBOutlet weak var zumbledLetterStackView1: UIStackView!
    @IBOutlet weak var zumbledLetterStackView2: UIStackView!
    @IBOutlet weak var scoreLabel: UILabel!

    let viewModel = LogoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.delegate = self
        viewModel.loadLogos()
    }
    
    func setupUI() {
        scoreLabel.text = "Score: 0"
        logoImageView.layer.cornerRadius = 8
        logoImageView.clipsToBounds = true
        logoImageView.contentMode = .scaleAspectFit
    }
    
    private func setupLetterStackView(for name: String) {
        letterStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for _ in name {
            let textField = UITextField()
            textField.textAlignment = .center
            textField.font = UIFont.systemFont(ofSize: 24)
            textField.borderStyle = .roundedRect
            textField.isUserInteractionEnabled = false
            letterStackView.addArrangedSubview(textField)
        }
    }
    
    private func setupJumbledLetters(for name: String) {
        zumbledLetterStackView1.arrangedSubviews.forEach { $0.removeFromSuperview() }
        zumbledLetterStackView2.arrangedSubviews.forEach { $0.removeFromSuperview() }
        let nameSet: Set<Character> = Set(name.shuffled())
        var letters = Array(viewModel.generateExtraLetters(for: nameSet, count: 18 - nameSet.count))
        letters += nameSet
        letters.shuffle()
        for (index, letter) in letters.enumerated() {
            let button = UIButton(type: .system)
            button.setTitle(String(letter), for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
            button.setTitleColor(.blue, for: .normal)
            button.backgroundColor = .white
            button.layer.borderWidth = 1.0
            button.layer.borderColor = UIColor.gray.cgColor
            button.layer.cornerRadius = 8
            button.addTarget(self, action: #selector(letterButtonTapped(_:)), for: .touchUpInside)
            
            if index < 9 {
                zumbledLetterStackView1.addArrangedSubview(button)
            } else {
                zumbledLetterStackView2.addArrangedSubview(button)
            }
        }
    }
    
    
    @objc private func letterButtonTapped(_ sender: UIButton) {
        guard let letter = sender.title(for: .normal),
              let currentLogo = viewModel.currentLogo else { return }
        
        let textFields = letterStackView.arrangedSubviews.compactMap { $0 as? UITextField }
        
        if let emptyTextField = textFields.first(where: { $0.text?.isEmpty ?? true }) {
            emptyTextField.text = letter
            
            let currentText = textFields.compactMap { $0.text }.joined()
            if currentText.count == currentLogo.name.count {
                if currentText.uppercased() == currentLogo.name.uppercased() {
                    let alert = UIAlertController(title: "Correct!", message: "Well done!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Next", style: .default) { _ in
                        self.viewModel.incrementScore() // Increment score here
                        self.viewModel.nextLogo()
                    })
                    present(alert, animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(title: "Incorrect", message: "Sorry, Not Matched. Please try again.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                        textFields.forEach { $0.text = "" }
                    })
                    present(alert, animated: true, completion: nil)
                }
            }
        }
    }
}

extension LogoQuizViewController: LogoViewModelDelegate {
    func didUpdateLogos() {
        guard let currentLogo = viewModel.currentLogo else { return }
        viewModel.loadImage()
        setupLetterStackView(for: currentLogo.name)
        setupJumbledLetters(for: currentLogo.name)
    }
    
    func didLoadLogoImage(data: Data) {
        logoImageView.image = UIImage(data: data)
    }
    
    func didUpdateScore(_ score: Int) {
        scoreLabel.text = "Score: \(score)"
    }
}
