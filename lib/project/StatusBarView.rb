module StatusBarView
  #  VIEW GENERATORS

  def notice_view(text, accessory)
    # Create notice view
    notice_view = UIView.alloc.initWithFrame(CGRectMake(0, statusbar_height, statusbar_width, statusbar_height))
    notice_view.backgroundColor = UIColor.redColor

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