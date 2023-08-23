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
        let backColor = #colorLiteral(red: 0.01487923693, green: 0.04629518837, blue: 0.1187677309, alpha: 1)
        
        view.backgroundColor = backColor
        self.title = "Characters"
        
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
        
        let appearanceWhite = UINavigationBarAppearance()
        appearanceWhite.largeTitleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        
        let appearanceDark = UINavigationBarAppearance()
        appearanceDark.largeTitleTextAttributes = [
            .foregroundColor: backColor
        ]
        
        navigationController?.navigationBar.standardAppearance = appearanceWhite
        //navigationController?.navigationBar.scrollEdgeAppearance = appearanceDark
        
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
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CharacterCollectionViewCell.self, forCellWithReuseIdentifier: "CharacterCell")
        collectionView.showsVerticalScrollIndicator = false
    }
    
    func loadCharacterInfoAndPushToView(selectedCharacter: Character) {
        guard let imageUrl = URL(string: selectedCharacter.image) else {
            return
        }
        
        URLSession.shared.dataTask(with: imageUrl) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    let episodeURLs = selectedCharacter.episode.map { URL(string: $0) }
                    let episodeLoadGroup = DispatchGroup()
                    var episodes: [Episode] = []

                    for episodeURL in episodeURLs {
                        if let episodeURL = episodeURL {
                            episodeLoadGroup.enter()
                            URLSession.shared.dataTask(with: episodeURL) { data, _, _ in
                                if let data = data {
                                    do {
                                        let episode = try JSONDecoder().decode(Episode.self, from: data)
                                        episodes.append(episode)
                                    } catch {
                                        print("Error decoding episode data: \(error)")
                                    }
                                }
                                episodeLoadGroup.leave()
                            }.resume()
                        }
                    }

                    episodeLoadGroup.notify(queue: DispatchQueue.main) {
                        let characterInfoView = CharacterInfo(
                            characterName: selectedCharacter.name,
                            characterImage: image,
                            characterStatus: selectedCharacter.status,
                            characterSpecies: selectedCharacter.species,
                            characterType: selectedCharacter.type,
                            characterGender: selectedCharacter.gender,
                            characterPlanet: selectedCharacter.location.name,
                            characterPlanetType: selectedCharacter.location.type,
                            episodes: episodes
                        )
                        let characterInfoHostingController = UIHostingController(rootView: characterInfoView)
                        self.navigationController?.pushViewController(characterInfoHostingController, animated: true)
                    }
                }
            }
        }.resume()
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCharacter = characters[indexPath.item]
        loadCharacterInfoAndPushToView(selectedCharacter: selectedCharacter)
    }
}


