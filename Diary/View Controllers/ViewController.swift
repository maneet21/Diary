
//MARK:- Start
import UIKit
import AVKit

class ViewController: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    //MARK:- Variables Declaration
    var videoPlayer: AVPlayer?
    var videoPlayerLayer: AVPlayerLayer?
 
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpElements()
        
        print(1)
        print(2)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpVideo()
    }
    
    //MARK:- User-Defined Functions
    func setUpElements() {
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleHollowButton(loginButton)
    }
    
    func setUpVideo() {
        let bundlePath = Bundle.main.path(forResource: "loginbg", ofType: "mp4")
       
        guard bundlePath != nil else {
            return
        }
        
        let url = URL(fileURLWithPath: bundlePath!)
        let item = AVPlayerItem(url: url)
        
        videoPlayer = AVPlayer(playerItem: item)
        videoPlayerLayer = AVPlayerLayer(player: videoPlayer!)
        videoPlayerLayer?.frame = CGRect(x: -self.view.frame.size.width*1.5, y: 0, width: self.view.frame.size.width*4, height: self.view.frame.size.height)
        
        view.layer.insertSublayer(videoPlayerLayer!, at: 0)
        
        videoPlayer?.playImmediately(atRate: 0.5)
    }
}
//MARK:- End
