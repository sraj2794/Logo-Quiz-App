//
//  LogoViewModel.swift
//  LogoStarterProject
//
//  Created by Raj Shekhar on 17/06/24.
//


//intiate timer
// ScoreManager
////func incrementScore()
//func decrementScore()

import Foundation

protocol LogoViewModelDelegate: AnyObject {
    func didUpdateLogos()
    func didLoadLogoImage(data: Data)
    func didUpdateScore(_ score: Int)
}

final class LogoViewModel {
    weak var delegate: LogoViewModelDelegate?
    private(set) var logos: [Logo] = []
    private var currentIndex: Int = 0
    private var score: Int = 0

    private let logoLoader: LogoLoader
    private let imageLoader: ImageLoader
   
    init(logoLoader: LogoLoader = LogoLoader(), imageLoader: ImageLoader = ImageLoader()) {
        self.logoLoader = logoLoader
        self.imageLoader = imageLoader
    }
    
    var currentLogo: Logo? {
        return currentIndex < logos.count ? logos[currentIndex] : nil
    }
    
    func loadLogos() {
        logoLoader.loadLogos { [weak self] result in
            switch result {
            case .success(let logos):
                self?.logos = logos
                DispatchQueue.main.async {
                    self?.delegate?.didUpdateLogos()
                }
            case .failure(let error):
                print("Failed to load logos: \(error)")
            }
        }
    }
    
    func loadImage() {
        guard let currentLogo = currentLogo else { return }
        
        imageLoader.loadImage(from: currentLogo.imgUrl) { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.delegate?.didLoadLogoImage(data: data)
                }
            case .failure(let error):
                print("Failed to load image: \(error)")
            }
        }
    }
    
    func nextLogo() {
        currentIndex = (currentIndex + 1) % logos.count
        delegate?.didUpdateLogos()
    }
    
    func incrementScore() {
        score += 10
        delegate?.didUpdateScore(score)
    }
    
    func generateExtraLetters(for name: Set<Character>, count: Int) -> [Character] {
        let alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        var extraLetters = [Character]()
        var availableLetters = Set(alphabet).subtracting(name)
        for _ in 0..<count {
            if let letter = availableLetters.randomElement() {
                print("letter random: \(letter)")
                extraLetters.append(letter)
                availableLetters.remove(letter)
            }
        }
        
        return extraLetters
    }

}
