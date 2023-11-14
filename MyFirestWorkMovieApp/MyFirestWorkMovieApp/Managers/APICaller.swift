//
//  APICaller.swift
//  MyFirestWorkMovieApp
//
//  Created by Artem Krasko on 09.11.2022.
//

import Foundation


struct Constans{
    static let API_KEY = "4ff9f5fd03c3fa8e60c03c17102adfb6"
    static let baseURl = "https://api.themoviedb.org"
    static let YouTubeAPI_KEY = "AIzaSyAMfR4y3ypWpBSaSyT45R-55MTlrAzACkQ"
    static let YouTubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
}

enum APIError: Error{
    case failedTogetData
}

class APICaller{
    static let shared = APICaller()
    
    
    func getTrendingMovies(completion: @escaping (Result<[Title],Error>) -> Void) {
        guard let url = URL(string: "\(Constans.baseURl)/3/trending/movie/day?api_key=\(Constans.API_KEY)") else {return}
        let tack = URLSession.shared.dataTask(with: URLRequest(url: url))  { data, _,error in
            guard let data = data ,error == nil else {
                return
            }
            
            do{
                let results = try JSONDecoder().decode(TrendindingTitleResponse.self, from: data)
                completion(.success(results.results))
                
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        tack.resume()
        
    }
    
    func getTrendingTVS(completion: @escaping (Result<[Title],Error>) -> Void) {
        guard let url = URL(string: "\(Constans.baseURl)/3/trending/tv/day?api_key=\(Constans.API_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                let results = try JSONDecoder().decode(TrendindingTitleResponse.self, from: data)
                completion(.success(results.results))
            }
            catch{
                completion(.failure(APIError.failedTogetData))            }
        }
        task.resume()
    }
    
    
    
    
    func getUpconingMovies(completion: @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constans.baseURl)/3/movie/upcoming?api_key=\(Constans.API_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                let results = try JSONDecoder().decode(TrendindingTitleResponse.self, from: data)
                completion(.success(results.results))
            }
            catch{
                completion(.failure(APIError.failedTogetData))            }
        }
        task.resume()
    }
    
    func getPopular(completion: @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constans.baseURl)/3/movie/popular?api_key=\(Constans.API_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                let results = try JSONDecoder().decode(TrendindingTitleResponse.self, from: data)
                completion(.success(results.results))
                
            }catch{
                completion(.failure(APIError.failedTogetData))            }
        }
        task.resume()
    }
    
    func getTopRated(completion: @escaping(Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constans.baseURl)/3/movie//top_rated?api_key=\(Constans.API_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                let results = try JSONDecoder().decode(TrendindingTitleResponse.self, from: data)
                completion(.success(results.results))
                
            }catch{
                completion(.failure(APIError.failedTogetData))
                
            }
        }
        task.resume()
        
    }
    
    func getDiscoverMovies(completion: @escaping(Result<[Title], Error>) -> Void) {
        
        guard let url = URL(string: "\(Constans.baseURl)/3/discover/movie?api_key=\(Constans.API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                let results = try JSONDecoder().decode(TrendindingTitleResponse.self, from: data)
                completion(.success(results.results))
                
            }catch{
                completion(.failure(APIError.failedTogetData))
                
            }
        }
        task.resume()
    }
    func search(with query:String, completion: @escaping(Result<[Title], Error>) -> Void) {
        
        guard let url = URL(string: "\(Constans.baseURl)/3/search/movie?api_key=\(Constans.API_KEY)&query=\(query)") else {
            return
            
        }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                let results = try JSONDecoder().decode(TrendindingTitleResponse.self, from: data)
                completion(.success(results.results))
                
            }catch{
                completion(.failure(APIError.failedTogetData))
                
            }
        }
        task.resume()
    }
    
    func getMovie(with query: String, completion: @escaping (Result<VideoElement, Error>) -> Void) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constans.YouTubeBaseURL)q=\(query)&key=\(Constans.YouTubeAPI_KEY)") else
            {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            
            do{
                let results = try JSONDecoder().decode(YouTubeSearchResponse.self, from: data)
                completion(.success(results.items[0]))
                
            } catch {
                completion(.failure(error))
                print(error.localizedDescription)
                
            }
        }
        task.resume()
    }
    
}
