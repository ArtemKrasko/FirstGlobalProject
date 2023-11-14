//
//  HomeViewController.swift
//  MyFirestWorkMovieApp
//
//  Created by Artem Krasko on 03.11.2022.
//

import UIKit



enum Sections: Int{
    case TrendingMovies = 0
    case TrendingTv = 1
    case Popular = 2
    case Upcoming = 3
    case TopRated = 4
}

class HomeViewController: UIViewController {
    
    private var randomTrandingMovie: Title?
    private var headerView: HeroHeaderIUView?
    
    
    let sectionTitiles: [String] = ["Trending Movies", "Trending TV", "Popular", "Upcoming Movies", "Top rated"]
    
    private let homeFeedTable: UITableView = {
        
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionviewTableViewCell.self, forCellReuseIdentifier: CollectionviewTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(homeFeedTable)
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
        cofigureNavbar()
        
        headerView = HeroHeaderIUView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 584))
        homeFeedTable.tableHeaderView = headerView
        configureHeroHeaderView()
    }
    
    private func configureHeroHeaderView(){
        APICaller.shared.getTrendingMovies{ [weak self] result in
            switch result{
            case.success(let titles):
                let selectedTitle = titles.randomElement()
                
                self?.randomTrandingMovie = selectedTitle
                
                self?.headerView?.configure(with: TitleViewModel(titleName: selectedTitle?.original_title ?? "", posterURL: selectedTitle?.poster_path ?? ""  ))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func cofigureNavbar(){
        var image  = UIImage(named: "netflixLogo")
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
            
        ]
        navigationController?.navigationBar.tintColor = .black
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
    
}


extension HomeViewController:UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitiles.count
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        guard let cell =  tableView.dequeueReusableCell(withIdentifier: CollectionviewTableViewCell.identifier, for: indexPath) as? CollectionviewTableViewCell else{
            return UITableViewCell()
        }
        cell.delegate = self
        
        
        switch indexPath.section {
        case Sections.TrendingMovies.rawValue:
            APICaller.shared.getTrendingMovies { result in
                switch result {
                case.success(let titles):
                    cell.configure(with: titles)
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        case Sections.TrendingTv.rawValue:
            APICaller.shared.getTrendingTVS { result in
                switch result{
                case.success(let titles):
                    cell.configure(with: titles)
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        case Sections.Popular.rawValue:
            APICaller.shared.getPopular { result in
                switch result{
                case.success(let title):
                    cell.configure(with: title)
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        case Sections.Upcoming.rawValue:
            APICaller.shared.getUpconingMovies { result in
                switch result{
                case.success(let title):
                    cell.configure(with: title)
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
            
            
        case Sections.TopRated.rawValue:
            APICaller.shared.getTopRated { result in
                switch result {
                case .success(let title):
                    cell.configure(with: title)
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
            
            
        default:
            return UITableViewCell()
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .black
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitiles[section]
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.right
        let offset = scrollView.contentOffset.y + defaultOffset
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
}

extension HomeViewController: CollectionviewTableViewCellDelegate {
    func collectionviewTableViewCellDidTabCell(_ cell: CollectionviewTableViewCell, viewModel: TitilePreviewViewModel) {
        DispatchQueue.main.async { [weak self] in
            let vc = TitlePreviewViewController()
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
