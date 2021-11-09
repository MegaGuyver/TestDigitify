//
//  ViewController.swift
//  test
//
//  Created by Khawaja Fahad on 08/11/2021.
//

import UIKit
import ProgressHUD

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    lazy var viewModel = {
        ViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        initViewModel()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.getTrackFromAPI()
    }
    
    func initView() {
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.register(TrackTableViewCell.self, forCellReuseIdentifier: TrackTableViewCell.identifier)
    }
    
    
    func initViewModel() {
        
        // Reload TableView closure
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                ProgressHUD.dismiss()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getnumberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.gettitleForHeaderInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.getCell(tableView, cellForRowAt: indexPath)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }
}

