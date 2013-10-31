class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.makeKeyAndVisible
    @window.backgroundColor = "#ffffff".uicolor
    @window.rootViewController = DemoController.alloc.init
    
    true
  end
end
