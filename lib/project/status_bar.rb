class StatusBar
  # include statusbar_helper.rb
  # include StatusbarHelper

  K_accessory_dimension = 14

  def initialize(rotation_effect = "rotate")
    # Create statusbar view
    @statusbar_view = UIView.alloc.initWithFrame(hidden_statusbar_view_frame(Device.interface_orientation))
    @statusbar_view.backgroundColor = background_color
    @statusbar_view.clipsToBounds = true
    App.shared.keyWindow.addSubview(@statusbar_view)

    # Set old orientation and rotation effect
    @old_orientation = Device.interface_orientation
    @rotation_effect = rotation_effect

    # Listen for rotation
    App.notification_center.observe UIDeviceOrientationDidChangeNotification do |notification|
      application_rotated(notification)
    end
  end



  # EXTERNAL COMMANDS

  def show_notice(text, accessory = nil)
    reposition_statusbar_view unless statusbar_view_visible?
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

  def hide_notice
    hide_statusbar_view

    # Remove subviews after certain amount of time
    @statusbar_view.subviews.each do |view|
      0.3.second.later { view.removeFromSuperview }
    end
  end

  def visible?
    statusbar_view_visible?
  end



  # INTERNAL COMMANDS

  def show_status_bar
    if !statusbar_view_visible?
      App.shared.setStatusBarHidden(true, withAnimation:UIStatusBarAnimationSlide)
      0.4.second.later { @statusbar_view.move_to([statusbar_view_frame(Device.interface_orientation).x, statusbar_view_frame(Device.interface_orientation).y]) }
    end
  end

  def hide_statusbar_view
    if statusbar_view_visible?
      @statusbar_view.move_to([hidden_statusbar_view_frame(@old_orientation).x, hidden_statusbar_view_frame(@old_orientation).y])
      0.4.second.later { App.shared.setStatusBarHidden(false, withAnimation:UIStatusBarAnimationSlide) }
    end
  end



  # HELPER FUNCTIONS

  def statusbar_width
    Device.screen.width_for_orientation(Device.interface_orientation)
  end

  def statusbar_height
    20
  end

  def statusbar_x
    0
  end

  def statusbar_y

  end

  def landscape?
    landscape_left?(Device.interface_orientation) || landscape_right?(Device.interface_orientation)
  end

  def portrait?
    right_side_up?(Device.interface_orientation)
  end

  def right_side_up?(orientation)
    orientation == :portrait
  end

  def landscape_left?(orientation)
    orientation == :landscape_left
  end

  def landscape_right?(orientation)
    orientation == :landscape_right
  end

  def upside_down?(orientation)
    orientation == :portrait_upside_down
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

  def degrees
    transform = 0.degrees
    if landscape_left?(Device.interface_orientation)
      transform = 270.degrees
    elsif landscape_right?(Device.interface_orientation)
      transform = 90.degrees
    end

    transform
  end

  def textwidth(text)
    text.sizeWithFont(font).width
  end

  def accessory_x(text)
    (statusbar_width/2) - (textwidth(text) / 2) - 10
  end

  def label_x(text)
    (statusbar_width/2) - (textwidth(text) / 2)
  end

  def statusbar_view_x(orientation)
    case orientation
    when :portrait then 0 
    when :landscape_left then 0 
    when :landscape_right then Device.screen.width-statusbar_height
    end
  end 

  def statusbar_view_y(orientation)
    case orientation
    when :portrait then 0
    when :landscape_left then 0
    when :landscape_right then 0
    end
  end

  def statusbar_view_width(orientation)
    case orientation
    when :portrait then statusbar_width
    when :landscape_left then statusbar_height
    when :landscape_right then statusbar_height
    end
  end

  def statusbar_view_height(orientation)
    case orientation
    when :portrait then statusbar_height
    when :landscape_left then statusbar_width
    when :landscape_right then statusbar_width
    end
  end

  def statusbar_view_frame(orientation)
    CGRectMake(statusbar_view_x(orientation), statusbar_view_y(orientation), statusbar_view_width(orientation), statusbar_view_height(orientation))
  end

  def hidden_statusbar_view_frame(orientation)
    frame = statusbar_view_frame(orientation)

    case orientation
    when :portrait then frame.y = -statusbar_height
    when :landscape_left then frame.x = -20
    when :landscape_right then frame.x = Device.screen.width
    end

    return frame
  end

  def reposition_statusbar_view
    @statusbar_view.rotate_to(duration: 0.0, angle: degrees)
    @statusbar_view.frame = hidden_statusbar_view_frame(Device.interface_orientation)
  end

  def application_rotated(notification)
    return unless portrait? || landscape?
    return unless statusbar_view_visible?
    return if @old_orientation == Device.interface_orientation

    if @rotation_effect == "rotate"
      UIView.animation_chain {
        @statusbar_view.rotate_to(duration: 0.3, angle: degrees)
        @statusbar_view.frame = statusbar_view_frame(Device.interface_orientation)

        @statusbar_view.subviews.each do |view|
          view_frame = view.frame
          view_frame.width = statusbar_width
          view.width = statusbar_width
          view.move_to([0, 0])

          label_view = view.viewWithTag(1)
          accessory_view = view.viewWithTag(2)

          label_view.x = label_x(label_view.text) if label_view.present?
          accessory_view.x = accessory_x(label_view.text) if accessory_view.present?
          label_view.x += 10 if accessory_view.present?
        end
      }.start
    elsif @rotation_effect == "slide"
      slide_in_frame = hidden_statusbar_view_frame(@old_orientation)
      @statusbar_view.move_to([slide_in_frame.x, slide_in_frame.y])

      0.3.second.later {
        @statusbar_view.rotate_to(duration: 0.0, angle: degrees)
        @statusbar_view.frame = hidden_statusbar_view_frame(Device.interface_orientation)

        @statusbar_view.subviews.each do |view|
          view_frame = view.frame
          view_frame.width = statusbar_width
          view.width = statusbar_width
          view.move_to([0, 0])

          label_view = view.viewWithTag(1)
          accessory_view = view.viewWithTag(2)

          label_view.x = label_x(label_view.text) if label_view.present?
          accessory_view.x = accessory_x(label_view.text) if accessory_view.present?
          label_view.x += 10 if accessory_view.present?
        end

        0.1.second.later {
          UIView.animation_chain {
            @statusbar_view.frame = statusbar_view_frame(Device.interface_orientation)
          }.start
        }
      }
    end

    # Set old orientation to new orientation
    @old_orientation = Device.interface_orientation

  end

  def statusbar_view_visible?
    @statusbar_view.present? && @statusbar_view.y.to_i == statusbar_view_frame(@old_orientation).y && @statusbar_view.x.to_i == statusbar_view_frame(@old_orientation).x
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
    if accessory.present? 
      accessory_view.x = accessory_x(text)
      label_view.x += 10
    end

    # Add notice view to statusbar view
    @statusbar_view.addSubview(notice_view)

    return notice_view
  end

  def label_view(text)
    label_view = UILabel.alloc.initWithFrame(CGRectMake(label_x(text), 0, textwidth(text), statusbar_height))
    label_view.backgroundColor = UIColor.clearColor
    label_view.adjustsFontSizeToFitWidth = false
    label_view.textAlignment = ios_6? ? UITextAlignmentCenter : NSTextAlignmentCenter
    label_view.baselineAdjustment = UIBaselineAdjustmentAlignCenters
    label_view.textColor = color
    label_view.font = font
    label_view.text = text
    label_view.tag = 1

    return label_view
  end

  def image_view(image)
    new_image = image.uiimage
    image_view = UIImageView.alloc.initWithFrame(CGRectMake(0, 3, K_accessory_dimension, K_accessory_dimension))
    image_view.image = new_image.rt_tintedImageWithColor(color, level:1)
    image_view.tag = 2

    return image_view
  end

  def spinner_view
    spinner_view = UIActivityIndicatorView.alloc.initWithActivityIndicatorStyle(UIActivityIndicatorViewStyleWhite)
    spinner_view.frame = CGRectMake(0, 3, K_accessory_dimension, K_accessory_dimension)
    spinner_view.hidesWhenStopped = true
    spinner_view.transform = CGAffineTransformMakeScale(K_accessory_dimension/spinner_view.width, K_accessory_dimension/spinner_view.width)
    spinner_view.startAnimating
    spinner_view.color = color
    spinner_view.tag = 2

    return spinner_view
  end

end