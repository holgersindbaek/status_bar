Teacup::Stylesheet.new :custom_style do

  p "TESTING"
  
  style :statusbar,
    width: "100%",
    height: 17,
    x: 0,
    y: 0,
    backgroundColor: UIColor.redColor

  style :test_view,
    origin: [10, 10],
    width: 30,
    height: 30,
    backgroundColor: UIColor.brownColor

end