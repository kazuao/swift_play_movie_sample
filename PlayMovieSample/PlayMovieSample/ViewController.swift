//
//  ViewController.swift
//  PlayMovieSample
//
//  Created by Kazunori Aoki on 2021/04/20.
//

import UIKit
import MediaPlayer
import AVKit

class ViewController: UIViewController {
    
    @IBOutlet weak var movieView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //画面向きを左横画面でセットする
        UIDevice.current.setValue(4, forKey: "orientation")
        
        //画面の向きを変更させるために呼び出す。
        print(supportedInterfaceOrientations)
        
        setVideoView()
    }
    
    func setVideoView() {
        guard let path = Bundle.main.path(forResource: "sea", ofType: "mp4") else {
            print("nothing movie file")
            return
        }
        
        let url = URL.init(fileURLWithPath: path)
        let player = AVPlayer.init(url: url)
        let controller = AVPlayerViewController.init()
        // 再生ボタン等の表示切り替え
        controller.showsPlaybackControls = true
        controller.player = player
        controller.view.frame = CGRect(x:0, y: 0, width: self.movieView.bounds.size.width, height: self.movieView.bounds.size.height)
        self.addChild(controller)
        self.movieView.addSubview(controller.view)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(ViewController.didPlayEndTime),
                                               name: .AVPlayerItemDidPlayToEndTime,
                                               object: player.currentItem)
    }
    
    @objc func didPlayEndTime() {
        print("finished")
        self.dismiss(animated: false, completion: nil)
    }
    
    // 横画面固定にする
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        
        //左横画面に変更
        if (UIDevice.current.orientation.rawValue == 4) {
            UIDevice.current.setValue(4, forKey: "orientation")
            return .landscapeLeft
            
        } else {
            //最初の画面呼び出しで画面を右横画面に変更させる。
            UIDevice.current.setValue(3, forKey: "orientation")
            return .landscapeRight
        }
    }
    
    // 画面を自動で回転させるかを決定する。
    override var shouldAutorotate: Bool {
        
        //画面が縦だった場合は回転させない
        if (UIDevice.current.orientation.rawValue == 1) {
            return false
        } else {
            return true
        }
    }
}

