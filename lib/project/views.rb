#  VIEW GENERATORS
def notice_view(text, accessory)

  # Create notice view
  notice_view = UIView.alloc.initWithFrame(CGRectMake(0, statusbar_height, statusbar_width, statusbar_height))
  notice_view.backgroundColor = UIColor.clearColor

  layout(notice_view) do
    subview(UIButton, :hi_button)
  end

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
    accessory_view.frame.x = accessory_x(text)
    label_view.frame.x += 10
  end

  # Add notice view to statusbar view
  @statusbar_view.addSubview(notice_view)

  return notice_view
end

def label_view(text)
  p color
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
  image_view = UIImageView.alloc.initWithFrame(CGRectMake(0, 3, K_accessory_dimension, K_accessory_dimension))
  image_view.image = image.uiimage.overlay(color)
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