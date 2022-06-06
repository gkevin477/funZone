//
//  SongsViewController.swift
//  funZone
//
//  Created by admin on 5/29/22.
//

import UIKit

class SongsViewController: UIViewController{

    @IBOutlet var searchBar: UITextField!
    @IBOutlet weak var songsTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        configureSongs()
        songsTable.delegate = self
        songsTable.dataSource = self
        searchBar.delegate = self
    }
    
    var songs = [Song]()
    var filteredSongs = [Song]()
    var filtered = false
    
    func configureSongs(){
        songs.append(Song(name: "Broken", artistName: "Lund", trackName: "Broken"))
        songs.append(Song(name: "Tom's Diner (Cover)", artistName: "AnnenMayKantereit x Giant Rooks", trackName: "Tom's_Diner_(Cover)"))
        songs.append(Song(name: "Rookie of the Year", artistName: "Chris Webby", trackName: "Rookie_of_the_Year"))
        songs.append(Song(name: "Tell The Reaper I'm Sorry", artistName: "Lil Revive", trackName: "Tell_The_Reaper_I'm_Sorry"))
        songs.append(Song(name: "Broken", artistName: "Lund", trackName: "Broken"))
        songs.append(Song(name: "Tom's Diner (Cover)", artistName: "AnnenMayKantereit x Giant Rooks", trackName: "Tom's_Diner_(Cover)"))
        songs.append(Song(name: "Rookie of the Year", artistName: "Chris Webby", trackName: "Rookie_of_the_Year"))
        songs.append(Song(name: "Tell The Reaper I'm Sorry", artistName: "Lil Revive", trackName: "Tell_The_Reaper_I'm_Sorry"))
        songs.append(Song(name: "Broken", artistName: "Lund", trackName: "Broken"))
        songs.append(Song(name: "Tom's Diner (Cover)", artistName: "AnnenMayKantereit x Giant Rooks", trackName: "Tom's_Diner_(Cover)"))
        songs.append(Song(name: "Rookie of the Year", artistName: "Chris Webby", trackName: "Rookie_of_the_Year"))
        songs.append(Song(name: "Tell The Reaper I'm Sorry", artistName: "Lil Revive", trackName: "Tell_The_Reaper_I'm_Sorry"))
    }
    
}

extension SongsViewController:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let text = textField.text{
            filterText(text + string)
        }
        
        return true
    }
    
    func filterText(_ query: String){
        filteredSongs.removeAll()
        for string in songs{
            if string.name.lowercased().starts(with: query.lowercased()){
                filteredSongs.append(string)
            }
        }
        songsTable.reloadData()
        if(query != "\n"){
            print(query)
            filtered = true
        }else{
            filtered = false
        }
    }
}





extension SongsViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let position = indexPath.row
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "Player") as! PlayerViewController? else{
            return
        }
        vc.songs = songs
        vc.position = position
        present(vc, animated: true, completion: nil)
    }
}

extension SongsViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(!filteredSongs.isEmpty){
            return filteredSongs.count
        }
        
        return filtered ? 0 : songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var song = songs[indexPath.row]
        if(!filteredSongs.isEmpty){
            song = filteredSongs[indexPath.row]
        }


        
        cell.textLabel?.text = song.name
        cell.detailTextLabel?.text = song.artistName
        cell.imageView?.image = UIImage(named: song.trackName)
        cell.accessoryType = .disclosureIndicator
        
        cell.textLabel?.font = UIFont(name: "Helvetica-Bold", size: 18)
        cell.textLabel?.font = UIFont(name: "Helvetica", size: 17)
        return cell
    }
}

struct Song{
    let name : String
    let artistName : String
    let trackName : String
}
