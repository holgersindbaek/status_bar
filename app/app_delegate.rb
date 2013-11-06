class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.backgroundColor = UIColor.clearColor
    @window.rootViewController = DemoController.new
    @window.makeKeyAndVisible
    
    true
  end
end
