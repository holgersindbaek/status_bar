include StatusBar

Teacup::Stylesheet.new :status_bar_style do

  style :status_bar_view,
    width: Device.screen.width_for_orientation(Device.interface_orientation),
    height: 20,
    left: 0,
    top: 0, #Should be -20
    backgroundColor: UIColor.redColor,
    clipsToBounds: true

  style UIView,
    width: "100%",
    height: 20,
    left: 0,
    top: 0

  style :notice_label,
    adjustsFontSizeToFitWidth: false,
    textAlignment: NSTextAlignmentCenter,
    baselineAdjustment: UIBaselineAdjustmentAlignCenters,
    textColor: StatusBar::Helper.text_color,
    text: "notice_label"

end

# label_view = UILabel.alloc.initWithFrame(CGRectMake(label_x(text), 0, textwidth(text), statusbar_height))
    #   label_view.backgroundColor = UIColor.clearColor
    #   label_view.adjustsFontSizeToFitWidth = false
    #   label_view.textAlignment = ios_6? ? UITextAlignmentCenter : NSTextAlignmentCenter
    #   label_view.baselineAdjustment = UIBaselineAdjustmentAlignCenters
    #   label_view.textColor = color
    #   label_view.font = font
    #   label_view.text = text
    #   label_view.tag = 1