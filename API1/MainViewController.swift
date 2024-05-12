//
//  ViewController.swift
//  API1
//
//  Created by Smart Castle M1A2009 on 21.10.2023.
//

import UIKit
import SDWebImage

class MainViewController: UIViewController {
    
    var mainData: MoviesResult?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .orange
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayouts()
        setupSignals()
        getData()
    }
    
    func setupLayouts() {
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func setupSignals() {
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: "cellId")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func getData() {
        Service.shared.fetchJSonData(urlString: "https://api.themoviedb.org/3/discover/movie") { res, err in
            print("res \(res)")
            print("err \(err)")
            
            if let err = err {
                print("ERROR")
                return
            }
            
            if let res = res {
                self.mainData = res
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}
    
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let result = mainData?.results[indexPath.row] else { return }
        let vc = DetailViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainData?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! MainTableViewCell
        cell.backgroundColor = .white
        if let data = mainData?.results[indexPath.row] {
            cell.nameLabel.text = data.title
            cell.descLabel.text = data.overview
            if let path = data.posterPath {
                let imageUrl = "https://image.tmdb.org/t/p/w300_and_h450_bestv2/"
                guard let url = URL(string: imageUrl + path) else { return cell }
                cell.customImageView.sd_setImage(with: url)
            }
        }
        return cell
    }
}
    
class MainTableViewCell: UITableViewCell {
    
    lazy var customImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "posterDemo")?.withRenderingMode(.alwaysOriginal)
        imageView.backgroundColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Expand4"
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var descLabel: UILabel = {
        let label = UILabel()
        label.text = "Armed with every weapon they can get their hands on and the skills to use them!"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayouts()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayouts() {
        backgroundColor = .lightGray
        
        addSubview(customImageView)
        customImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        customImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        customImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        customImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: customImageView.rightAnchor, constant: 20).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        addSubview(descLabel)
        descLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 30).isActive = true
        descLabel.leftAnchor.constraint(equalTo: customImageView.rightAnchor, constant: 20).isActive = true
        descLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        descLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
                
    }
    
}

import SwiftUI
@available(iOS 13.0, *)
struct MainVCProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        func updateUIViewController(_ uiViewController: MainViewController, context: Context) {
    
        }
        
        let mainVC = MainViewController()
        func makeUIViewController(context: UIViewControllerRepresentableContext<MainVCProvider.ContainerView>) -> MainViewController {
            return mainVC
        }
        
    }
}





