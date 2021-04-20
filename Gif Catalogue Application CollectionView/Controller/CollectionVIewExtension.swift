//
//  CollectionVIewExtension.swift
//  Gif Catalogue Application CollectionView/Users/karlis.stekels/Desktop/Gif Catalogue Application CollectionView/Gif Catalogue Application CollectionView/Model
//
//  Created by karlis.stekels on 19/04/2021.
//

import Foundation
extension CollectionViewController {
    //MARK: - SetUp
    func searchBarSetUp() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        self.definesPresentationContext = true
    }
    
    func navigationBarSetUp() {
        title = "Gif Catalogue App"
        searchController.searchBar.delegate = self
    }
    
    
    //MARK: - Data
    func reloadData(for searchText: String = "hello") {
        
        urlString = "https://api.giphy.com/v1/gifs/search?q=\(searchText)&api_key=jfm68wbEKZVLAAcD0Yh7k6Zqq1LcNfr9"
        
        if let url = URL(string: urlString) {
            print(url)
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }
        
        DispatchQueue.main.async {
            print("Loading...")
            self.collectionView.reloadData()
        }
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        if let jsonGifs = try? decoder.decode(Gifs.self, from: json) {
            gifs = jsonGifs.data
            print("Parsing Successfull")
            collectionView.reloadData()
        } else {
            print("Parsing Error")
        }
    }
}

