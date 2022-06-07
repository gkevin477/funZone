//
//  NotesViewController.swift
//  funZone
//
//  Created by admin on 6/4/22.
//

import UIKit

class NotesViewController: UIViewController {

    @IBOutlet var notesIn: UITextView!
    @IBOutlet var notesColllection: UICollectionView!
    
    var notes: [Note] = []
    var index: Int = -1
    
    @IBAction func save(_ sender: Any) {
        
        UDM.shared.defaults.setValue(notes.count + 1, forKey: "notes.count")
        UDM.shared.defaults.setValue(notesIn.textStorage.string, forKey: "text \(notes.count)")
        
        if let value = UDM.shared.defaults.value(forKey: "text \(notes.count)") as? String{
            notes.append(Note(text: value))
            notesColllection.reloadData()
        }
    }
    
    @IBAction func update(_ sender: Any?) {
        if(index != -1){
            UDM.shared.defaults.setValue(notesIn.textStorage.string, forKey: "text \(index)")
            
            if let value = UDM.shared.defaults.value(forKey: "text \(index)") as? String{
                notes[index].text = value
                print(value)
                notesColllection.reloadData()
            }
        }
    }
    
    @IBAction override func delete(_ sender: Any?) {
        if(index != -1){

            
            let store = notes.count - index
            if(store > 0){
                for val in 0..<(store - 1) {
                    UDM.shared.defaults.setValue(notes[index + val + 1].text, forKey: "text \(notes[index + val])")
                }
            }
            UDM.shared.defaults.setValue(notes.count - 1, forKey: "notes.count")
            notes.remove(at: index)
            notesColllection.reloadData()
            index = -1
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notesIn.layer.cornerRadius = 20
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 120, height: 120)
        notesColllection.collectionViewLayout = layout
        // Do any additional setup after loading the view.
        notesColllection.register(NotesCollectionViewCell.nib(), forCellWithReuseIdentifier: NotesCollectionViewCell.identifier)
        
        notesColllection.delegate = self
        notesColllection.dataSource = self
        
        
        if let value1 = UDM.shared.defaults.value(forKey: "notes.count") as? Int{
            for val in 0...value1{
                if let value = UDM.shared.defaults.value(forKey: "text \(val)") as? String{
                    notes.append(Note(text: value))
                    notesColllection.reloadData()
                    print(value)
                }
            }
        }
    }
    
    
    struct Note{
        var text: String
    }
    

}

extension NotesViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        notesColllection.deselectItem(at: indexPath, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        index = indexPath.row
        let note = notes[index]
        notesIn.text = note.text
    }
    
}
extension NotesViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = notesColllection.dequeueReusableCell(withReuseIdentifier: NotesCollectionViewCell.identifier, for: indexPath) as! NotesCollectionViewCell
        let note = notes[indexPath.row]
        
        cell.configure(with: String(note.text))
        cell.layer.cornerRadius = 20
        cell.layer.masksToBounds = true
        
        return cell
    }
    
}
extension NotesViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath)->CGSize{
        return CGSize(width: 120, height: 120)
        
    }
}



class UDM {
    static let shared = UDM()
    
    let defaults = UserDefaults(suiteName: "com.test.saved.data")!
    
}
