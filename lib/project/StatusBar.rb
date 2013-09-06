class Statusbar

  K_accessory_dimension = 14

  def initialize
    # Create statusbar view
    @statusbar_view = UIView.alloc.initWithFrame(CGRectMake(0, -statusbar_height, statusbar_width, statusbar_height))
    @statusbar_view.backgroundColor = background_color
    @statusbar_view.clipsToBounds = true
    App.shared.keyWindow.addSubview(@statusbar_view)

    image_view = UIImageView.alloc.initWithFrame(CGRectMake(0, 0, 200, 200))
    image_view.image = "duck".uiimage
    App.shared.keyWindow.addSubview(image_view)

    # Listen for rotation
    App.notification_center.observe UIDeviceOrientationDidChangeNotification do |notification|
      application_rotated(notification)
    end
  end



  # EXTERNAL COMMANDS

  def show_notice(text, accessory = nil)
    reposition_statusbar_view
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
    view = notice_view(text, accessory)
    view.move_to([0, 0])

    # Hide view again if success or error
    3.second.later { hide_notice if view.isDescendantOfView(@statusbar_view) } if accessory == "success" || accessory == "error"
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
    if @statusbar_view.y < 0
      App.shared.setStatusBarHidden(true, withAnimation:UIStatusBarAnimationSlide)
      0.4.second.later { @statusbar_view.move_to([0, 0]) }
    end
  end

  def hide_statusbar_view
    if @statusbar_view.y == 0
      @statusbar_view.move_to([0, -statusbar_height])
      0.4.second.later { App.shared.setStatusBarHidden(false, withAnimation:UIStatusBarAnimationSlide) }
    end
  end



  #  VIEW GENERATORS

  def notice_view(text, accessory)
    # Create notice view
    notice_view = UIView.alloc.initWithFrame(CGRectMake(0, statusbar_height, statusbar_width, statusbar_height))
    notice_view.backgroundColor = UIColor.clearColor

    # Add label view to notice view
    label_view = label_view(text)
    notice_view.addSubview(label_view)

    # Add accessory if needed 
    accessory_view =  case accessory
                      when "activity" then spinner_view
                      when "success" then image_view("success")
                      when "error" then image_view("error")
                      else nil
                      end
    notice_view.addSubview(accessory_view)

    # Place accessory and label correctly
    if accessory != nil 
      text_width = text.sizeWithFont(font).width
      accessory_view.x = (statusbar_width/2) - (text_width / 2) - 10
      label_view.x = 10
    end

    # Add notice view to statusbar view
    @statusbar_view.addSubview(notice_view)

    return notice_view
  end

  def label_view(text)
    label_view = UILabel.alloc.initWithFrame(CGRectMake(0, 0, statusbar_width, statusbar_height))
    label_view.backgroundColor = UIColor.clearColor
    label_view.adjustsFontSizeToFitWidth = false
    label_view.textAlignment = ios_6? ? UITextAlignmentCenter : NSTextAlignmentCenter
    label_view.baselineAdjustment = UIBaselineAdjustmentAlignCenters
    label_view.textColor = color
    label_view.font = font
    label_view.text = text

    return label_view
  end

  def image_view(image)
    image_view = UIImageView.alloc.initWithFrame(CGRectMake(0, 3, K_accessory_dimension, K_accessory_dimension))
    image_view.image = image.uiimage

    return image_view
  end

  def spinner_view
    spinner_view = UIActivityIndicatorView.alloc.initWithActivityIndicatorStyle(UIActivityIndicatorViewStyleWhite)
    spinner_view.frame = CGRectMake(0, 3, K_accessory_dimension, K_accessory_dimension)
    spinner_view.hidesWhenStopped = true
    spinner_view.transform = CGAffineTransformMakeScale(K_accessory_dimension/spinner_view.width, K_accessory_dimension/spinner_view.width)
    spinner_view.startAnimating
    spinner_view.color = color

    return spinner_view
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

  def font
    UIFont.boldSystemFontOfSize(ios_7? ? 12 : 14)
  end

  def ios_7?
    Device.ios_version.to_i >= 7
  end

  def ios_6?
    Device.ios_version.to_i >= 6
  end

  def color
    local_color = UIColor.blackColor
    case App.shared.statusBarStyle
    when UIStatusBarStyleDefault, UIStatusBarStyleBlackTranslucent, UIStatusBarStyleBlackOpaque
      local_color = "#bcbcbc".uicolor unless ios_7?
    when UIStatusBarStyleLightContent
      local_color = "#ffffff".uicolor
    end

    return local_color
  end

  def background_color
    return ios_7? ? UIColor.clearColor : UIColor.blackColor
  end

  def rotation_transform
    transform = 0.degrees
    if landscape_left?(Device.interface_orientation)
      transform = 270.degrees
    elsif landscape_right?(Device.interface_orientation)
      transform = 90.degrees
    end

    CGAffineTransformMakeRotation(transform)
  end

  def reposition_statusbar_view
    @statusbar_view.frame = CGRectMake(0, 0, statusbar_width, statusbar_height)
    @statusbar_view.bounds = CGRectMake(0, 0, statusbar_width, statusbar_height)
    @statusbar_view.transform = rotation_transform
    @statusbar_view.x = 0
    @statusbar_view.y = -20
  end

  def application_rotated(notification)
    # TODO - Create really nice animation of the statusbar rotation and changing to new position

    # transform = CGAffineTransformMakeTranslation(0, 0);
    # transform = CGAffineTransformRotate(transform, 0.degrees);
    # UIView.animate do
    #   @statusbar_view.transform = transform
    # end
  end

end

