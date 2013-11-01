include StatusBar

Teacup::Stylesheet.new :status_bar_style do

  style :status_bar_view,
    height: 20,
    left: 0,
    top: 20,
    clipsToBounds: true,
    portrait: {
      width: HS::Base.rotation_width(:portrait),
      backgroundColor: UIColor.redColor,
      height: 20
    },
    landscape: {
      width: HS::Base.rotation_width(:landscape_left),
      backgroundColor: UIColor.blueColor,
      height: 40
    }

  style UIView,
    width: "100%",
    height: 20,
    left: 0

  style UILabel,
    adjustsFontSizeToFitWidth: false,
    textAlignment: StatusBar::Helper.label_alignment,
    baselineAdjustment: UIBaselineAdjustmentAlignCenters,
    textColor: StatusBar::Helper.label_color,
    font: StatusBar::Helper.label_font

  style UIImageView,
    left: 0,
    top: 3,
    width: 14,
    height: 14



  style :notice_view,
    top: 20

  style :notice_label,
    text: "Notice Label"



  style :activity_view,
    top: 20

  style :activity_label,
    text: "Activity Label"

  style :activity_spinner,
    left: 0,
    top: 5,
    width: 14,
    height: 14,
    activityIndicatorViewStyle: UIActivityIndicatorViewStyleWhite,
    hidesWhenStopped: true,
    color: StatusBar::Helper.label_color,
    transform: CGAffineTransformMakeScale(0.75, 0.75)



  style :success_view,
    top: 20

  style :success_label,
    text: "Success Label"

  style :success_image,
    image: "success".uiimage #.overlay("#000000")



  style :error_view,
    top: 20

  style :error_label,
    text: "Error Label"

  style :error_image,
    image: "error".uiimage #.overlay("#000000")

end