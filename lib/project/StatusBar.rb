class Statusbar
  # include statusbar_helper.rb
  include StatusbarHelper

  K_accessory_dimension = 14

  def initialize
    # Create statusbar view
    @statusbar_view = UIView.alloc.initWithFrame(CGRectMake(0, -statusbar_height, statusbar_width, statusbar_height))
    @statusbar_view.backgroundColor = background_color
    @statusbar_view.clipsToBounds = true
    App.shared.keyWindow.addSubview(@statusbar_view)

    # Listen for rotation
    App.notification_center.observe UIDeviceOrientationDidChangeNotification do |notification|
      application_rotated(notification)
    end
  end



  # EXTERNAL COMMANDS

  def show_notice(text, accessory = nil)
    # reposition_statusbar_view
    # reposition_statusbar_view unless @statusbar_view.x == 0 && @statusbar_view.y == 0

    # If statusbar is already shown, don't do anything

    # Else show statusbar
    show_status_bar

    # Hide old notices
    @statusbar_view.subviews.each do |view|
      view.move_to([0, -statusbar_height])
      0.3.second.later { view.removeFromSuperview }
    end

    # Show new notice
    new_view = notice_view(text, accessory)
    new_view.move_to([0, 0])

    # Hide view again if success or error
    3.second.later { hide_notice if new_view.isDescendantOfView(@statusbar_view) } if accessory == "success" || accessory == "error"
  end

  def show_activity_notice(text)
    show_notice(text, "activity")
  end

  def show_success_notice(text)
    show_notice(text, "success")
  end

  def show_error_notice(text)
    show_notice(text, "error")
  end

  # Hide notice
  def hide_notice
    hide_statusbar_view

    # Remove subviews after certain amount of time
    @statusbar_view.subviews.each do |view|
      0.3.second.later { view.removeFromSuperview }
    end
  end



  # INTERNAL COMMANDS

  def show_status_bar
    if !statusbar_view_visible?
      App.shared.setStatusBarHidden(true, withAnimation:UIStatusBarAnimationSlide)
      0.4.second.later { @statusbar_view.move_to([0, 0]) }
    end
  end

  def hide_statusbar_view
    if statusbar_view_visible?
      @statusbar_view.move_to([0, -statusbar_height])
      0.4.second.later { App.shared.setStatusBarHidden(false, withAnimation:UIStatusBarAnimationSlide) }
    end
  end

end