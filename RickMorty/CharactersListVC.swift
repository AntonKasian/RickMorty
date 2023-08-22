//
//  ViewController.swift
//  RickMorty
//
//  Created by Anton on 22.08.23.
//

import UIKit
import SwiftUI

class CharactersListVC: UIViewController {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 156, height: 202)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        self.title = "Characters"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(collectionView)
        setupCollectionView()
        
    }
    
    func setupCollectionView() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -25),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CharacterCollectionViewCell.self, forCellWithReuseIdentifier: "CharacterCell")
        collectionView.showsVerticalScrollIndicator = false
    }
}

extension CharactersListVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCell", for: indexPath) as! CharacterCollectionViewCell
        
        cell.characterImageView.image = UIImage(named: "rick")
        cell.characterNameLabel.text = "Rick Sanchez"
        
        return cell
    }
    
    // Переход на CharacterInfo
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCharacterName = "Rick Sanchez" // Получите имя персонажа из данных
        
        let characterInfoView = CharacterInfo(characterName: selectedCharacterName)
        let characterInfoHostingController = UIHostingController(rootView: characterInfoView)
        navigationController?.pushViewController(characterInfoHostingController, animated: true)
    }
    
}

class CharacterCollectionViewCell: UICollectionViewCell {
    
    let characterImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
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


