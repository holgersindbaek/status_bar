Teacup::Stylesheet.new :demo do

  style :demo_view,
    backgroundColor: "#000000".uicolor

  style :container,
    top: 20,
    backgroundColor: "#ffffff".uicolor,
    portrait: {
      width: "100%",
      height: "100%-20"
    },
    landscape: {
      width: "100%",
      height: "100%-20"
    }

  style UIButton,
    height: 40,
    left: 10,
    layer: {
      borderWidth: 1,
      borderColor: "#c8c7cc".uicolor.CGColor,
      cornerRadius: 8
    },
    landscape: {
      width: "50%-15"
    },
    portrait: {
      width: "100%-20"
    }

  style :show_notice_button,
    title: 'Show Notice',
    top: 10

  style :show_activity_button,
    title: 'Show Activity',
    portrait: {
      top: 60,
      left: 10
    },
    landscape: { 
      top: 10,
      left: "50%+5"
    }

  style :show_success_button,
    title: 'Show Success',
    portrait: {
      top: 110,
    },
    landscape: { 
      top: 60,
    }

  style :show_error_button,
    title: 'Show Error',
    portrait: {
      top: 160,
      left: 10
    },
    landscape: { 
      top: 60,
      left: "50%+5"
    }

  style :hide_notice_button,
    title: 'Hide Notice',
    portrait: {
      top: 210,
    },
    landscape: { 
      top: 110,
    }

  style :visibility_button,
    title: 'Visible?',
    portrait: {
      top: 260,
      left: 10
    },
    landscape: { 
      top: 110,
      left: "50%+5"
    }

end