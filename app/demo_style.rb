Teacup::Stylesheet.new :demo do

  style UIButton,
    width: "100%-20",
    height: 40,
    x: 10,
    layer: {
      borderWidth: 1,
      borderColor: "#c8c7cc".uicolor.CGColor,
      cornerRadius: 8
    }

  style :show_notice_button,
    y: 40,
    title: 'Show Notice'

  style :show_activity_button,
    y: 90,
    title: 'Show Activity'

  style :show_success_button,
    y: 140,
    title: 'Show Success'

  style :show_error_button,
    y: 190,
    title: 'Show Error'

  style :hide_notice_button,
    y: 240,
    title: 'Hide Notice'

  style :visibility_button,
    y: 340,
    title: 'Visible?'

end