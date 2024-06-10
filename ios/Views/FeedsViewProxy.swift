import SwiftUI
class FeedsViewProxy: UIView {
    
    var returningView: UIView?
    let appModel: AppModel = .init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let vc = UIHostingController(rootView: FeedsView(
            stagesModel: appModel.stagesModel,
            stageModel: appModel.stageModel
        ).environmentObject(appModel))
        vc.view.frame = bounds
        self.addSubview(vc.view)
        self.returningView = vc.view
        
        checkAVPermissions { granted in
            if !granted {
                self.appModel.appendErrorMessage("No camera/microphone permission granted")
            }
        }
        
        appModel.createStage(.video)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc var customerCode: NSString = "" {
        didSet{
            UserDefaults.standard.set(customerCode.lowercased(with: Locale.current), forKey: Constants.kCustomerCode)
            self.appModel.verify(silent: true) { _ in }
        }
    }
    
    @objc var apiKey: NSString = "" {
        didSet{
            UserDefaults.standard.set(apiKey, forKey: Constants.kApiKey)
        }
    }
    
    @objc var isMuted: Bool = false {
        didSet{
            appModel.stageModel.toggleLocalAudioMute(muted: isMuted)
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.returningView?.frame = bounds
    }
    
}
