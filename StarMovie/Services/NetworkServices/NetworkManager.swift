//
//  NetworkManager.swift
//  StarMovie
//
//  Created by petar on 08.05.2024.
//

import Foundation

protocol NetworkServicesMovie{
    func getPopularMovieList(complition: @escaping (Result<[Movie], Error>) -> Void)
}

class NetworkManager: NetworkServicesMovie {
    
    static let shared = NetworkManager()
    
    func getPopularMovieList(complition: @escaping (Result<[Movie], any Error>) -> Void){
        guard let url = URL(string: "\(Resources.Url.baseURL)movie/popular?api_key=\(Resources.Url.keyApi)") else { return }
        URLSession.shared.dataTask(with: url){ data, _, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                do{
                    let result = try JSONDecoder().decode(Movies.self, from: data)
                    complition(.success(result.results))
                }catch{
                    complition(.failure(error))
                }
            }
        }.resume()
    }
    
    func getImageForMovie(imageLink: String, complition: @escaping (_ imageData: Data) -> ()){
        guard let url = URL(string: "\(Resources.Url.imageUrlPath)\(imageLink)") else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            complition(data)
        }.resume()
    }

}
