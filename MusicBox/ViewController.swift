import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .red
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        DataServiceManager.shared.searchRelatedMusics(page: 0, limit: 30, keyword: "周杰伦", channel: .KuWo)
    }
}

