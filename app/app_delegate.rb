class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.makeKeyAndVisible
    @window.backgroundColor = "#000000".uicolor
    @window.rootViewController = DemoController.new
    
    true
  end
end
