

import UIKit

class ViewController: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    let imageView = UIImageView(image: UIImage(named: "sample.jpg")!)

    //最後一道關卡
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        
        imageView.contentMode = .scaleAspectFit
        scrollView.addSubview(imageView)
        scrollView.zoomScale = 1.0
        print("只摳一次")
    }
    //倒數第二道關卡
    override func viewDidAppear(_ animated: Bool) {
        imageView.frame = scrollView.bounds
        print("我是一號")
        print(scrollView.contentSize)
        scrollView.contentSize = imageView.frame.size
        //scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //scrollView.contentOffset = CGPoint(x: 0, y: 0)

    }
    //支援縮放
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    //旋轉的action
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {

        scrollView.bounds.size = CGSize(width: size.width, height: size.height)
        imageView.frame.size = scrollView.bounds.size
        
        print("我是二號")
        //scrollView.zoomScale = 1.0
    }
    //加這個從landscape到upsidedown才會有反應
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .all
    }
    //Document說一定要implenmentation但我不知道怎麼用
//    func scrollViewDidZoom(_ scrollView: UIScrollView) {
//        <#code#>
//    }

//    func setZoomScale() {
//        let imageViewSize = imageView.bounds.size
//        let scrollViewSize = scrollView.bounds.size
//        let widthScale = scrollViewSize.width / imageViewSize.width
//        let heightScale = scrollViewSize.height / imageViewSize.height
//        scrollView.minimumZoomScale = min(widthScale, heightScale)
//        scrollView.zoomScale = 1.0
//    }
}

