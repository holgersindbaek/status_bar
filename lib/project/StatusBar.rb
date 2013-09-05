class Statusbar

  K_accessory_width = 14
  K_accessory_height = 14

  def initialize
    # Create statusbar view
    @statusbar_view = UIView.alloc.initWithFrame(CGRectMake(0, -statusbar_height, statusbar_width, statusbar_height))
    @statusbar_view.backgroundColor = UIColor.blackColor
    @statusbar_view.clipsToBounds = true

    # Create notice view
    @notice_view = notice("Loading...")

    # Create success image
    @success_view = UIImageView.alloc.initWithFrame(CGRectMake(0, 0, 20, 20))
    @success_view.image = UIImage.imageNamed("success.png")
    @statusbar_view.addSubview(@success_view)

    # Create error image

    # Create spinner

    App.shared.keyWindow.addSubview(@statusbar_view)
  end



  # EXTERNAL COMMANDS

  # Show notice
  def show_notice(text)
    show_status_bar

    if @notice_view.y < 20
      # Move new notice in
      notice_view = notice(text)
      notice_view.move_to([0, 0])

      # Move old notice out and replace the view
      hide_notice_view_up
      0.3.second.later { 
        @notice_view.removeFromSuperview
        @notice_view = nil
        @notice_view = notice_view 
      }
    else
      @notice_view.text = text
      show_notice_view
    end
  end

  # Show activity notice

  # Show success notice
  def show_success_notice(text)
    show_status_bar

    # @success_view.move_to([0, 0])
  end

  # Show error notice

  # Hide notice
  def hide_notice
    hide_status_bar
    0.3.second.later { hide_notice_view_down }
  end



  # INTERNAL COMMANDS

  # Show status bar
  def show_status_bar
    if !App.shared.isStatusBarHidden
      @statusbar_view.y = 0
      App.shared.setStatusBarHidden(true, withAnimation:UIStatusBarAnimationSlide)
    end
  end

  # Hide status bar
  def hide_status_bar
    if App.shared.isStatusBarHidden
      App.shared.setStatusBarHidden(false, withAnimation:UIStatusBarAnimationSlide)
      0.4.second.later { @statusbar_view.y = -statusbar_height }
    end
  end

  def show_notice_view
    @notice_view.move_to([0, 0])
  end

  def hide_notice_view_up
    @notice_view.move_to([0, -statusbar_height])
  end

  def hide_notice_view_down
    @notice_view.move_to([0, statusbar_height])
  end



  # HELPER FUNCTIONS

  def statusbar_width
    # App.shared.statusBarFrame.size.width
    Device.screen.width_for_orientation(Device.interface_orientation)
  end

  def statusbar_height
    # App.shared.statusBarFrame.size.height
    20
  end

  def notice(text)
    notice_view = UILabel.alloc.initWithFrame(CGRectMake(0, statusbar_height, statusbar_width, statusbar_height))
    notice_view.backgroundColor = UIColor.clearColor
    notice_view.adjustsFontSizeToFitWidth = false
    notice_view.textAlignment = Device.ios_version.to_i >= 6 ? UITextAlignmentCenter : NSTextAlignmentCenter
    notice_view.baselineAdjustment = UIBaselineAdjustmentAlignCenters
    notice_view.textColor = "#bcbcbc".uicolor
    notice_view.font = UIFont.boldSystemFontOfSize(14)
    notice_view.text = text
    @statusbar_view.addSubview(notice_view)

    return notice_view
  end

end

