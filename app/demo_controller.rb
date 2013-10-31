class DemoController < UIViewController
  stylesheet :demo

  layout do
    @show_notice_button = subview(UIButton.buttonWithType(UIButtonTypeRoundedRect), :show_notice_button)
    @show_activity_button = subview(UIButton.buttonWithType(UIButtonTypeRoundedRect), :show_activity_button)
    @show_success_button = subview(UIButton.buttonWithType(UIButtonTypeRoundedRect), :show_success_button)
    @show_error_button = subview(UIButton.buttonWithType(UIButtonTypeRoundedRect), :show_error_button)
    @hide_notice_button = subview(UIButton.buttonWithType(UIButtonTypeRoundedRect), :hide_notice_button)
    @visibility_button = subview(UIButton.buttonWithType(UIButtonTypeRoundedRect), :visibility_button)
  end

  def viewDidLoad
    super
  end

  def shouldAutorotate
    true
  end

end