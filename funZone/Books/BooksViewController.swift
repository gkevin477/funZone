//
//  BooksViewController.swift
//  funZone
//
//  Created by admin on 5/30/22.
//

import UIKit

class BooksViewController: UIViewController {

    @IBOutlet weak var booksCollection: UICollectionView!
    @IBOutlet weak var bookSumary: UILabel!
    
    @IBAction func readPdf(_ sender: Any){
        if(index != -1){
            let book = books[index]
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "Pdf") as! pdfViewController? else{
                return
            }
            vc.book = book.booksName
            present(vc, animated: true, completion: nil)
        }
    }
    
    var index: Int = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //create books contruct
        configureBooks()
        
        
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 120, height: 120)
        booksCollection.collectionViewLayout = layout
        // Do any additional setup after loading the view.
        booksCollection.register(BooksCollectionViewCell.nib(), forCellWithReuseIdentifier: BooksCollectionViewCell.identifier)
        booksCollection.delegate = self
        booksCollection.dataSource = self
    }
    
    var books = [Book]()
    func configureBooks(){
        books.append(Book(booksName: "20000 Leagues Under the Sea", booksSumary: "Sent to investigate mysterious encounters that are disrupting international shipping, Professor Aronnax, his servant Conseil, and disgruntled harpooner Ned Land are captured when their frigate is sunk during an encounter with the monster. The submarine Nautilus and its eccentric Captain Nemo afford the professor and his companions endless fascination and danger as they're swept along on a yearlong undersea voyage.", booksCoverName: "20000-Leagues-Under-the-Sea-1"))
        books.append(Book(booksName: "Induction", booksSumary: "They weren't supposed to exist.Sidonie & Sinclair Boudreau were the offspring of a witch and a shifter. Such pairings usually resulted in death. Sid & Sin had not only survived, but thrived, and managed to sidestep the family legacy of supernatural policing.The disappearance of their parents changed everything. A cryptic message, an ancient prophecy, and a mystery to uncover in order to bring their parents home puts the twins in the crosshairs of an enemy they didn't know existed What would you do, to save those you loved?Fans of paranormal mysteries will love this fast-paced, five star ride!", booksCoverName: "Induction-1"))
        books.append(Book(booksName: "The Reluctant Coroner", booksSumary: "Fenway Stevenson doesn't want to return to the coastal town where her estranged father is practically king. But the death of her mother draws her back home--and the murder of the county coroner draws her into a deepening conspiracy. As the body count rises and all signs seem to point toward her father's oil company, will Fenway uncover the truth before family bonds become deadly?", booksCoverName: "The-Reluctant-Coroner-1"))
        books.append(Book(booksName: "Murder on Tyneside", booksSumary: "Recently widowed Agnes Lockwood is spending a few days on Tyneside in Northeast England, catching up with her past. When expensive jewelry is stolen at the hotel, Chief Inspector Alan Johnson gets on the case. After Alan recognizes Agnes as a friend from schooldays, they rekindle their friendship and Agnes bombards him with questions about the case. But after dinner one evening, they find a body lying on the roadside.Fearing for her safety, Alan warns Agnes to stay away from the case. But being an inquisitive woman, Agnes cannot resist getting involved... too involved.", booksCoverName: "Murder-on-Tyneside-1"))
        books.append(Book(booksName: "20000 Leagues Under the Sea", booksSumary: "Sent to investigate mysterious encounters that are disrupting international shipping, Professor Aronnax, his servant Conseil, and disgruntled harpooner Ned Land are captured when their frigate is sunk during an encounter with the monster. The submarine Nautilus and its eccentric Captain Nemo afford the professor and his companions endless fascination and danger as they're swept along on a yearlong undersea voyage.", booksCoverName: "20000-Leagues-Under-the-Sea-1"))
        books.append(Book(booksName: "Induction", booksSumary: "They weren't supposed to exist.Sidonie & Sinclair Boudreau were the offspring of a witch and a shifter. Such pairings usually resulted in death. Sid & Sin had not only survived, but thrived, and managed to sidestep the family legacy of supernatural policing.The disappearance of their parents changed everything. A cryptic message, an ancient prophecy, and a mystery to uncover in order to bring their parents home puts the twins in the crosshairs of an enemy they didn't know existed What would you do, to save those you loved?Fans of paranormal mysteries will love this fast-paced, five star ride!", booksCoverName: "Induction-1"))
        books.append(Book(booksName: "The Reluctant Coroner", booksSumary: "Fenway Stevenson doesn't want to return to the coastal town where her estranged father is practically king. But the death of her mother draws her back home--and the murder of the county coroner draws her into a deepening conspiracy. As the body count rises and all signs seem to point toward her father's oil company, will Fenway uncover the truth before family bonds become deadly?", booksCoverName: "The-Reluctant-Coroner-1"))
        books.append(Book(booksName: "Murder on Tyneside", booksSumary: "Recently widowed Agnes Lockwood is spending a few days on Tyneside in Northeast England, catching up with her past. When expensive jewelry is stolen at the hotel, Chief Inspector Alan Johnson gets on the case. After Alan recognizes Agnes as a friend from schooldays, they rekindle their friendship and Agnes bombards him with questions about the case. But after dinner one evening, they find a body lying on the roadside.Fearing for her safety, Alan warns Agnes to stay away from the case. But being an inquisitive woman, Agnes cannot resist getting involved... too involved.", booksCoverName: "Murder-on-Tyneside-1"))
        books.append(Book(booksName: "20000 Leagues Under the Sea", booksSumary: "Sent to investigate mysterious encounters that are disrupting international shipping, Professor Aronnax, his servant Conseil, and disgruntled harpooner Ned Land are captured when their frigate is sunk during an encounter with the monster. The submarine Nautilus and its eccentric Captain Nemo afford the professor and his companions endless fascination and danger as they're swept along on a yearlong undersea voyage.", booksCoverName: "20000-Leagues-Under-the-Sea-1"))
        books.append(Book(booksName: "Induction", booksSumary: "They weren't supposed to exist.Sidonie & Sinclair Boudreau were the offspring of a witch and a shifter. Such pairings usually resulted in death. Sid & Sin had not only survived, but thrived, and managed to sidestep the family legacy of supernatural policing.The disappearance of their parents changed everything. A cryptic message, an ancient prophecy, and a mystery to uncover in order to bring their parents home puts the twins in the crosshairs of an enemy they didn't know existed What would you do, to save those you loved?Fans of paranormal mysteries will love this fast-paced, five star ride!", booksCoverName: "Induction-1"))
        books.append(Book(booksName: "The Reluctant Coroner", booksSumary: "Fenway Stevenson doesn't want to return to the coastal town where her estranged father is practically king. But the death of her mother draws her back home--and the murder of the county coroner draws her into a deepening conspiracy. As the body count rises and all signs seem to point toward her father's oil company, will Fenway uncover the truth before family bonds become deadly?", booksCoverName: "The-Reluctant-Coroner-1"))
        books.append(Book(booksName: "Murder on Tyneside", booksSumary: "Recently widowed Agnes Lockwood is spending a few days on Tyneside in Northeast England, catching up with her past. When expensive jewelry is stolen at the hotel, Chief Inspector Alan Johnson gets on the case. After Alan recognizes Agnes as a friend from schooldays, they rekindle their friendship and Agnes bombards him with questions about the case. But after dinner one evening, they find a body lying on the roadside.Fearing for her safety, Alan warns Agnes to stay away from the case. But being an inquisitive woman, Agnes cannot resist getting involved... too involved.", booksCoverName: "Murder-on-Tyneside-1"))
        books.append(Book(booksName: "20000 Leagues Under the Sea", booksSumary: "Sent to investigate mysterious encounters that are disrupting international shipping, Professor Aronnax, his servant Conseil, and disgruntled harpooner Ned Land are captured when their frigate is sunk during an encounter with the monster. The submarine Nautilus and its eccentric Captain Nemo afford the professor and his companions endless fascination and danger as they're swept along on a yearlong undersea voyage.", booksCoverName: "20000-Leagues-Under-the-Sea-1"))
        books.append(Book(booksName: "Induction", booksSumary: "They weren't supposed to exist.Sidonie & Sinclair Boudreau were the offspring of a witch and a shifter. Such pairings usually resulted in death. Sid & Sin had not only survived, but thrived, and managed to sidestep the family legacy of supernatural policing.The disappearance of their parents changed everything. A cryptic message, an ancient prophecy, and a mystery to uncover in order to bring their parents home puts the twins in the crosshairs of an enemy they didn't know existed What would you do, to save those you loved?Fans of paranormal mysteries will love this fast-paced, five star ride!", booksCoverName: "Induction-1"))
        books.append(Book(booksName: "The Reluctant Coroner", booksSumary: "Fenway Stevenson doesn't want to return to the coastal town where her estranged father is practically king. But the death of her mother draws her back home--and the murder of the county coroner draws her into a deepening conspiracy. As the body count rises and all signs seem to point toward her father's oil company, will Fenway uncover the truth before family bonds become deadly?", booksCoverName: "The-Reluctant-Coroner-1"))
        books.append(Book(booksName: "Murder on Tyneside", booksSumary: "Recently widowed Agnes Lockwood is spending a few days on Tyneside in Northeast England, catching up with her past. When expensive jewelry is stolen at the hotel, Chief Inspector Alan Johnson gets on the case. After Alan recognizes Agnes as a friend from schooldays, they rekindle their friendship and Agnes bombards him with questions about the case. But after dinner one evening, they find a body lying on the roadside.Fearing for her safety, Alan warns Agnes to stay away from the case. But being an inquisitive woman, Agnes cannot resist getting involved... too involved.", booksCoverName: "Murder-on-Tyneside-1"))
    }
    
    
    
    struct Book{
        var booksName: String
        var booksSumary: String
        var booksCoverName: String
    }

    
}


extension BooksViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let book = books[indexPath.row]
        index = indexPath.row
        bookSumary.numberOfLines = 0
        bookSumary.text = book.booksSumary
    }
}

extension BooksViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = booksCollection.dequeueReusableCell(withReuseIdentifier: BooksCollectionViewCell.identifier, for: indexPath) as! BooksCollectionViewCell
        let book = books[indexPath.row]
        
        cell.configure(with: UIImage(named: book.booksCoverName)!)
        
        return cell
    }
}

extension BooksViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath)->CGSize{
        return CGSize(width: 120, height: 120)}
}
