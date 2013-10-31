describe "A - AppDelegate" do
  
  before do
    @app = UIApplication.sharedApplication
  end

  it "has one window" do
    @app.windows.size.should == 1
  end

  it "should have correct root controller" do
    @app.keyWindow.rootViewController.class.should == DemoController
  end

end
