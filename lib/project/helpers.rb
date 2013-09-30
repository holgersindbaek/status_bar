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
  Device.ios_version.to_i == 7
end

def ios_6?
  Device.ios_version.to_i == 6
end

def dark_statusbar_style?
  case App.shared.statusBarStyle
  when UIStatusBarStyleDefault, UIStatusBarStyleBlackTranslucent, UIStatusBarStyleBlackOpaque
    return true unless ios_7?
  end

  return false
end

def color
  return "#ffffff".uicolor if App.shared.statusBarStyle == UIStatusBarStyleLightContent && ios_7?
  return "#bcbcbc1".uicolor if ios_6?
  return UIColor.blackColor
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
        view.frame.width = statusbar_width
        view.move_to([0, 0])

        label_view = view.viewWithTag(1)
        accessory_view = view.viewWithTag(2)

        label_view.frame.x = label_x(label_view.text) if label_view.present?
        accessory_view.x = accessory_x(label_view.text) if accessory_view.present?
        label_view.frame.x += 10 if accessory_view.present?
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

        label_view.frame.x = label_x(label_view.text) if label_view.present?
        accessory_view.frame.x = accessory_x(label_view.text) if accessory_view.present?
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
  @statusbar_view.present? && @statusbar_view.frame.y.to_i == statusbar_view_frame(@old_orientation).y && @statusbar_view.frame.x.to_i == statusbar_view_frame(@old_orientation).x
end