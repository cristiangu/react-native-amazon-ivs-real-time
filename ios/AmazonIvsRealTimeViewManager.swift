@objc(AmazonIvsRealTimeViewManager)
class AmazonIvsRealTimeViewManager: RCTViewManager {

  override func view() -> FeedsViewProxy? {
    return FeedsViewProxy()
  }

  @objc override static func requiresMainQueueSetup() -> Bool {
    return true
  }
}
