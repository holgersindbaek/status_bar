include StatusBar

Teacup::Stylesheet.new :status_bar_sheet do

  style :status_bar_view,
    height: 20,
    left: 0,
    top: 20,
    clipsToBounds: true,
    landscape: {
      width: "100%"
    },
    portrait: {
      width: "100%"
    }

  style UIView,
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

  style :standard_view,
    height: 20,
    landscape: {
      width: "100%"
    },
    portrait: {
      width: "100%"
    }



  style :notice_view, extends: :standard_view,
    top: 20

  style :notice_label, extends: :standard_view



  style :activity_view, extends: :standard_view,
    top: 20

  style :activity_label, extends: :standard_view

  style :activity_spinner,
    left: 0,
    top: 5,
    width: 14,
    height: 14,
    activityIndicatorViewStyle: UIActivityIndicatorViewStyleWhite,
    hidesWhenStopped: true,
    color: StatusBar::Helper.label_color,
    transform: CGAffineTransformMakeScale(0.75, 0.75)



  style :success_view, extends: :standard_view,
    top: 20

  style :success_label, extends: :standard_view

  style :success_image,
    image: "success".uiimage.overlay(StatusBar::Helper.label_color)



  style :error_view, extends: :standard_view,
    top: 20

  style :error_label, extends: :standard_view

  style :error_image,
    image: "error".uiimage.overlay(StatusBar::Helper.label_color)

end