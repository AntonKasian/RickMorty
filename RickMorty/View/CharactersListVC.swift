//
//  ViewController.swift
//  RickMorty
//
//  Created by Anton on 22.08.23.
//

import UIKit
import SwiftUI

class CharactersListVC: UIViewController {
    
    var characters: [Character] = []
    
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
        
        let networkManager = NetworkManager()

        networkManager.fetchCharacters { result in
            switch result {
            case .success(let characters):
                DispatchQueue.main.async {
                    self.characters = characters
                    self.collectionView.reloadData()
                    print("Data is ok")
                }
            case .failure(let error):
                print("Error fetching characters: \(error)")
            }
        }

        
    }
    
    func setupCollectionView() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -25),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CharacterCollectionViewCell.self, forCellWithReuseIdentifier: "CharacterCell")
        collectionView.showsVerticalScrollIndicator = false
    }
}

extension CharactersListVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCell", for: indexPath) as! CharacterCollectionViewCell
        
        let character = characters[indexPath.item]
        // Загрузка изображения из сети
        if let imageUrl = URL(string: character.image) {
                URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                    if let data = data, let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            cell.characterImageView.image = image
                        }
                    }
                }.resume()
            }
            cell.characterNameLabel.text = character.name
        
        return cell
    }
    
    // Переход на CharacterInfo
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCharacter = characters[indexPath.item]
        
        if let imageUrl = URL(string: selectedCharacter.image) {
            URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        let characterInfoView = CharacterInfo(characterName: selectedCharacter.name, characterImage: image)
                        let characterInfoHostingController = UIHostingController(rootView: characterInfoView)
                        self.navigationController?.pushViewController(characterInfoHostingController, animated: true)
                    }
                }
            }.resume()
        }
    }
    
}



