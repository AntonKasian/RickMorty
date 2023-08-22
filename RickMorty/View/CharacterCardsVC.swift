//
//  CharacterCardsVC.swift
//  RickMorty
//
//  Created by Anton on 22.08.23.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    
    let characterImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.layer.cornerRadius = 20
            imageView.clipsToBounds = true
            return imageView
        }()
        
        let characterNameLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            label.textColor = .black
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            
            addSubview(characterImageView)
            addSubview(characterNameLabel)
            
            NSLayoutConstraint.activate([
                characterImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
                characterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
                characterImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
                characterImageView.heightAnchor.constraint(equalToConstant: 140),
                
                characterNameLabel.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: 10),
                characterNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
                characterNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
                characterNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
            ])
            
            self.backgroundColor = .systemGray
            self.layer.cornerRadius = 20
        }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

