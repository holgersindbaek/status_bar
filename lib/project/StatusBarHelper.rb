module StatusbarHelper
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

  def right_side_up?(orientation)
    orientation == :portrait
  end

  def portrait?
    right_side_up?(Device.interface_orientation)
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

  def reposition_statusbar_view
    @statusbar_view.rotate_to(degrees)
    @statusbar_view.move_to([0, 0])
    # y = statusbar_view_visible? ? @statusbar_view.y : -statusbar_height 
    # @statusbar_view.frame = CGRectMake(0, y, statusbar_width, statusbar_height)
    # @statusbar_view.bounds = CGRectMake(0, 0, statusbar_width, statusbar_height)
    # # @statusbar_view.transform = rotation_transform
    # @statusbar_view.x = 0
    # @statusbar_view.y = y
  end

  def application_rotated(notification)
    return unless portrait? || landscape?
    0.5.second.later do
      frame = App.shared.statusBarFrame
      ap "              "
      ap Device.interface_orientation
      ap "frame.width: #{frame.width}"
      ap "frame.height: #{frame.height}"
      ap "frame.x: #{frame.x}"
      ap "frame.y: #{frame.y}"
      # @statusbar_view.bounds.size.width = statusbar_width
      # @statusbar_view.bounds.size.height = statusbar_height
      # ap "@statusbar_view.width: #{@statusbar_view.width}"
      # ap "@statusbar_view.height: #{@statusbar_view.height}"
      # ap "@statusbar_view.bounds.size.width: #{@statusbar_view.bounds.size.width}"
      # @statusbar_view.width = statusbar_width
      # @statusbar_view.height = statusbar_height
      @statusbar_view.subviews.each do |view|
        view.move_to([0, 0])
      end

      @statusbar_view.rotate_to(degrees)
      @statusbar_view.move_to([200, 200])
    end
    # TODO - Create really nice animation of the statusbar rotation and changing to new position

    # transform = CGAffineTransformMakeTranslation(0, 0);
    # transform = CGAffineTransformRotate(transform, 0.degrees);
    # UIView.animate do
    #   @statusbar_view.transform = transform
    # end
  end

  def statusbar_view_visible?
    ap "@statusbar_view.y"
    @statusbar_view.y == 0
  end

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
      text_width = text.sizeWithFont(font).width
      accessory_view.x = (statusbar_width/2) - (text_width / 2) - 10
      label_view.x += 10
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
    new_image = image.uiimage
    image_view = UIImageView.alloc.initWithFrame(CGRectMake(0, 3, K_accessory_dimension, K_accessory_dimension))
    image_view.image = image.uiimage.rt_tintedImageWithColor(color, level:1)

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

end
