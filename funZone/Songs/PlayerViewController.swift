//
//  PlayerViewController.swift
//  funZone
//
//  Created by admin on 6/2/22.
//

import UIKit
import AVFoundation

class PlayerViewController: UIViewController {

    public var position: Int = 0
    public var songs: [Song] = []
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var sLengthLabel: UILabel!
    @IBOutlet var holder: UIView!
    var player: AVAudioPlayer?
    var timer = Timer()
    //User Interface elements
    let playPauseButton = UIButton()
    var myTime: Int = 0
    
    
    @objc func updateTime(){
        
        if(resultLabel.text != sLengthLabel.text){
            myTime = myTime + 1
            let time = secondsToMinutes(seconds: myTime + 1)
            resultLabel.text = String(format: "%02d", time.0) + ":" + String(format: "%02d", time.1)
            guard let total = player?.duration else{
                return
            }
            progressBar.setProgress(Float(myTime) * Float(1 / total), animated: true)
        }
    }
    
    
        
    
    private let albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private let songNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    private let songArtistLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if holder.subviews.count == 0 {
            configure()
        }
    }
    
    func secondsToMinutes(seconds: Int) ->(Int, Int)
    {
        return (((seconds % 3600) / 60),((seconds % 3600) % 60))
    }
    
    
    
    
    func configure(){
        // set up player
        let song = songs[position]
        let urlString = Bundle.main.path(forResource: song.trackName, ofType: "mp3")
        print(song.trackName)
        // set up user interface elements

        //set up album cover
        albumImageView.frame = CGRect(x: 10, y: 10, width: holder.frame.size.width - 20, height: holder.frame.size.height / 2)
        albumImageView.image = UIImage(named: song.trackName)
        holder.addSubview(albumImageView)
        
        //Labels
        songNameLabel.frame = CGRect(x: 10, y: albumImageView.frame.size.height + 10, width: holder.frame.size.width - 20, height: 70)
        songArtistLabel.frame = CGRect(x: 10, y: albumImageView.frame.size.height + 10 + 70, width: holder.frame.size.width - 20, height: 70)
        
        songNameLabel.text = song.name
        songArtistLabel.text = song.artistName
        
        
        holder.addSubview(songNameLabel)
        holder.addSubview(songArtistLabel)
        
        
        //Player controls
        
        let nextButton = UIButton()
        let backButton = UIButton()
        
        //Frame
        let yPosition = songArtistLabel.frame.origin.y + 70 + 40
        let size: CGFloat = 70
        
        playPauseButton.frame = CGRect(x: (holder.frame.size.width - size) / 2.0, y: yPosition, width: size, height: size)
        nextButton.frame = CGRect(x: holder.frame.size.width - size - 20, y: yPosition, width: size, height: size)
        backButton.frame = CGRect(x: 20, y: yPosition, width: size, height: size)
        
        //Add actions
        playPauseButton.addTarget(self, action: #selector(didTapPlayPauseButton), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didTapFowardButton), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        
        //Styling controls
        playPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"),for: .normal)
        nextButton.setBackgroundImage(UIImage(systemName: "forward.fill"),for: .normal)
        backButton.setBackgroundImage(UIImage(systemName: "backward.fill"),for: .normal)
        
        playPauseButton.tintColor = .black
        nextButton.tintColor = .black
        backButton.tintColor = .black
        
        holder.addSubview(playPauseButton)
        holder.addSubview(nextButton)
        holder.addSubview(backButton)
        
        
        do{
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            guard let urlString = urlString else{
                return
            }
            
            
            player = try AVAudioPlayer(contentsOf: URL(string: urlString)!)
            
            guard let player = player else{
                return
            }

            player.play()
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
            let time = secondsToMinutes(seconds: Int(player.duration))
            sLengthLabel.text = String(format: "%02d", time.0) + ":" + String(format: "%02d", time.1)
            
        }
        catch{
            print("error: Could not find \(song.trackName).mp3 file")
        }
    }
    
    @objc func didTapBackButton(){
        if position > 0{
            position = position - 1
            player?.stop()
            for subView in holder.subviews{
                subView.removeFromSuperview()
            }
            progressBar.setProgress(0.0, animated: true)
            myTime = 0
            resultLabel.text = "00:00"
            timer.invalidate()
            configure()
        }
    }
    
    @objc func didTapPlayPauseButton(){
        if timer.isValid == true {
            
            timer.invalidate()
            player?.pause()
            // show play Button
            playPauseButton.setBackgroundImage(UIImage(systemName: "play.fill"),for: .normal)
            
            // shrink image size
            UIView.animate(withDuration: 0.2, animations: {
                self.albumImageView.frame = CGRect(x: 30, y: 30, width: self.holder.frame.size.width - 60, height: self.holder.frame.size.height / 2 - 20)
            })
        }
        else{
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
            player?.play()
            playPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"),for: .normal)
            
            //increase image size
            UIView.animate(withDuration: 0.2, animations: {
                self.albumImageView.frame = CGRect(x: 10, y: 10, width: self.holder.frame.size.width - 20, height: self.holder.frame.size.height / 2)
            })
        }
    }
    
    @objc func didTapFowardButton(){
        if position < songs.count - 1{
            position = position + 1
            player?.stop()
            for subView in holder.subviews{
                subView.removeFromSuperview()
            }
            progressBar.setProgress(0.0, animated: true)
            myTime = 0
            resultLabel.text = "00:00"
            timer.invalidate()
            configure()
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let player = player {
            player.stop()
        }
    }

}
