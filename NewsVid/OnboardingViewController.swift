//
//  OnboardingViewController.swift
//  NewsVid
//
//  Created by Anno Musa on 23/04/22.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    let helloLabel: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let hello = "Onboarding Screen"
        let font = UIFont.systemFont(ofSize: 24, weight: .bold)
        let height = font.lineHeight
        let width = hello.widthForHeight(height, font: font)
        
        helloLabel.text = hello
        helloLabel.font = font
        helloLabel.setW(width, andH: height)
        helloLabel.textColor = .black
        
        view.addSubview(helloLabel)
        
        helloLabel.center(with: view)
        
    }
    
}
