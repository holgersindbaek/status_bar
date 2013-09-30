K_accessory_dimension = 14

class StatusBar < UIView
  include Teacup::Layout
  stylesheet :custom_style

  def init
    p "init"
    self.initWithFrame(CGRectZero)
  end

  def initWithFrame(frame)
    p "frame: #{frame.to_a}"
    super
    
    layout(self, :statusbar) do
      subview(UIView, :test_view)
    end
      # layout(self, :statusbar) do


    App.shared.keyWindow.addSubview(self)
    p "init"
  end

  # def initialize(rotation_effect = "rotate")
  #   # Create statusbar view
  #   p "initialize"

  #   @statusbar_view = UIView.new

  #   layout(@statusbar_view) do 
  #     @test_view = subview(UIView, :test_view)
  #   end
    
  #   # @statusbar_view = UIView.alloc.initWithFrame(hidden_statusbar_view_frame(Device.interface_orientation))
  #   # @statusbar_view.backgroundColor = background_color
  #   # @statusbar_view.clipsToBounds = true
  #   # App.shared.keyWindow.addSubview(@statusbar_view)

  #   # # Set old orientation and rotation effect
  #   # @old_orientation = Device.interface_orientation
  #   # @rotation_effect = rotation_effect

  #   # # Listen for rotation
  #   # App.notification_center.observe UIDeviceOrientationDidChangeNotification do |notification|
  #   #   application_rotated(notification)
  #   # end
  # end



  # # EXTERNAL COMMANDS

  # def show_notice(text, accessory = nil)
  #   reposition_statusbar_view unless statusbar_view_visible?
  #   show_status_bar

  #   # Hide old notices
  #   @statusbar_view.subviews.each do |view|
  #     view.move_to([0, -statusbar_height])
  #     0.3.second.later { view.removeFromSuperview }
  #   end

  #   # Show new notice
  #   new_view = notice_view(text, accessory)
  #   new_view.move_to([0, 0])

  #   # Hide view again if success or error
  #   3.second.later { hide_notice if new_view.isDescendantOfView(@statusbar_view) } if accessory == "success" || accessory == "error"
  # end

  # def show_activity_notice(text)
  #   show_notice(text, "activity")
  # end

  # def show_success_notice(text)
  #   show_notice(text, "success")
  # end

  # def show_error_notice(text)
  #   show_notice(text, "error")
  # end

  # def hide_notice
  #   hide_statusbar_view

  #   # Remove subviews after certain amount of time
  #   @statusbar_view.subviews.each do |view|
  #     0.3.second.later { view.removeFromSuperview }
  #   end
  # end

  # def visible?
  #   statusbar_view_visible?
  # end



  # # INTERNAL COMMANDS

  # def show_status_bar
  #   if !statusbar_view_visible?
  #     App.shared.setStatusBarHidden(true, withAnimation:UIStatusBarAnimationSlide)
  #     0.4.second.later { @statusbar_view.move_to([statusbar_view_frame(Device.interface_orientation).x, statusbar_view_frame(Device.interface_orientation).y]) }
  #   end
  # end

  # def hide_statusbar_view
  #   if statusbar_view_visible?
  #     @statusbar_view.move_to([hidden_statusbar_view_frame(@old_orientation).x, hidden_statusbar_view_frame(@old_orientation).y])
  #     0.4.second.later { App.shared.setStatusBarHidden(false, withAnimation:UIStatusBarAnimationSlide) }
  #   end
  # end

end