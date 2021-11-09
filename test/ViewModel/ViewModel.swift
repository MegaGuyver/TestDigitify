//
//  ViewModel.swift
//  test
//
//  Created by Khawaja Fahad on 08/11/2021.
//

import Foundation
import ProgressHUD

class ViewModel {
        
    var sections = [Int]()
    
    private var trackService: TrackServiceProtocol
    
    var cellViewModels = [TrackViewModelArray]() {
        didSet {
            reloadTableView?()
        }
    }
    
    init(trackService: TrackServiceProtocol = TrackService()) {
        self.trackService = trackService
    }
    
    var reloadTableView: (() -> Void)?
    
    func getTrackFromAPI() {
        
        ProgressHUD.show("Calling API")

        trackService.getTracks { success, model, error in
            if success, let tracks = model {
                ProgressHUD.show("Saving Data")
                self.saveData(tracks: tracks)
            }
        }
    }
            
    func saveData(tracks: Tracks) {
        
        var ids = Set<Int>()
        var sectionCount = 0
        for track in tracks {
            let sectCount = ids.count
            ids.insert(track.albumId)
            DatabaseManager.shared.addObject(track: track)
            
            if sectCount > sectionCount {
                sectionCount += 1
                sections.append(track.albumId)
            }
        }
        
        ProgressHUD.show("Performing Operations")
        fetchhData()
    }
    
    func fetchhData() {
        var vms = [TrackViewModelArray]()
        for section in sections {
           let tracks = DatabaseManager.shared.getObjects(albumId: section)
            vms.append(TrackCellModelArray(tracks: tracks))
        }
        
        ProgressHUD.show("Populating Table")
        cellViewModels = vms
    }
    
   
    
    func TrackCellModelArray(tracks: TrackObjects) -> TrackViewModelArray {
        var vms = TrackViewModelArray()
        
        for track in tracks {
            vms.append(createCellModel(track: track))
        }
        
        return vms
    }
    
    func createCellModel(track: TrackObject) -> TrackCellViewModel {
        let title = track.title
        let thumbnailUrl = track.thumbnailUrl
        
        return TrackCellViewModel(title: title, thumbnailUrl: thumbnailUrl)
    }
        
    func getCellViewModel(at indexPath: IndexPath) -> TrackCellViewModel {
        return cellViewModels[indexPath.section][indexPath.row]
    }
    
    func getnumberOfRowsInSection(section: Int) -> Int {
        if self.sections.count == 0 {
           return 0
        }
        
        return self.cellViewModels[section].count
    }
    
    func gettitleForHeaderInSection(section: Int) -> String {
        if self.sections.count == 0 {
           return String()
        }
        return String(self.sections[section])
    }
    
    func getCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TrackTableViewCell.identifier, for: indexPath)

        cell.textLabel?.text = cellViewModels[indexPath.section][indexPath.row].title
        cell.detailTextLabel?.text = cellViewModels[indexPath.section][indexPath.row].thumbnailUrl

        return cell
    }
    
}
