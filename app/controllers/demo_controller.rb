class DemoController < UIViewController
  stylesheet :demo

  layout :demo_view do
    @container = subview(UIView, :container) do
      @show_notice_button = subview(UIButton.buttonWithType(UIButtonTypeRoundedRect), :show_notice_button)
      @show_activity_button = subview(UIButton.buttonWithType(UIButtonTypeRoundedRect), :show_activity_button)
      @show_success_button = subview(UIButton.buttonWithType(UIButtonTypeRoundedRect), :show_success_button)
      @show_error_button = subview(UIButton.buttonWithType(UIButtonTypeRoundedRect), :show_error_button)
      @hide_notice_button = subview(UIButton.buttonWithType(UIButtonTypeRoundedRect), :hide_notice_button)
      @visibility_button = subview(UIButton.buttonWithType(UIButtonTypeRoundedRect), :visibility_button)
    end
  end

  def viewDidLoad
    super

    ap "first viewDidLoad"

    @status_bar = StatusBar::Base.new

    @show_notice_button.when(UIControlEventTouchUpInside) {
      @status_bar.show_notice "This is a notice"
    }

    @show_activity_button.when(UIControlEventTouchUpInside) {
      @status_bar.show_activity_notice "Something's going on"
    }

    @show_success_button.when(UIControlEventTouchUpInside) {
      @status_bar.show_success_notice "Wohoo... made it!"
    }

    @show_error_button.when(UIControlEventTouchUpInside) {
      @status_bar.show_error_notice "Aww... no go"
    }

    @hide_notice_button.when(UIControlEventTouchUpInside) {
      @status_bar.hide_notice
    }

    @visibility_button.when(UIControlEventTouchUpInside) {
      ap @status_bar.visible?
    }
  end

  def shouldAutorotate
    true
  end

end