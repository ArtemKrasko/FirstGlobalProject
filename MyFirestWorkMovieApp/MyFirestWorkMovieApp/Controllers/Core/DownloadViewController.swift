//
//  DownloadViewController.swift
//  MyFirestWorkMovieApp
//
//  Created by Artem Krasko on 03.11.2022.
//

import UIKit

class DownloadViewController: UIViewController {
    
    private var titles: [TitleItem] = [TitleItem]()
    
    private let dawnloadedTable: UITableView = {
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Downloads"
        view.addSubview(dawnloadedTable)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        dawnloadedTable.delegate = self
        dawnloadedTable.dataSource = self
        fetchLocalStarageForDownloads()
    }
    
    private func fetchLocalStarageForDownloads(){
        DataPersistenceManager.shared.fetchingTitleFromDataBase { [weak self] result in
            switch result{
            case.success(let titles):
                self?.titles = titles
                DispatchQueue.main.async {
                    self?.dawnloadedTable.reloadData()
                    
                }
                self?.dawnloadedTable.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        dawnloadedTable.frame = view.bounds
    }
    
}
extension DownloadViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else {
            return UITableViewCell()
        }
        
        let title = titles[indexPath.row]
        
        cell.configure(with: TitleViewModel(titleName: (title.original_title ?? title.original_name) ?? "Unknown title name" ,posterURL: title.poster_path ?? ""))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle{
        case.delete:
            
            DataPersistenceManager.shared.deleteTitleWith(model: titles[indexPath.row]) {[weak self] result in
                switch result{
                    
                case .success():
                    print("delete from the data base")
                case .failure(let error):
                    print(error.localizedDescription)
                }
                self?.titles.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        default:
            break;
        }
    }
    
}
    
    
    
