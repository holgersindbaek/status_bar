module StatusBar
  class Base

    def initialize
      ap "1"
      # @status_bar_view = StatusBar::View.new
      # ap "2"
      # # Set old orientation and rotation effect
      # @old_orientation = Device.interface_orientation
      # @timer = nil

      # Listen for rotation
      # App.notification_center.observe UIDeviceOrientationDidChangeNotification do |notification|
      #   rotate_status_bar
      # end
    end



    # # EXTERNAL COMMANDS
    # def show_notice(text)
    #   show_notice_view(@status_bar_view.notice_view, notice_label:@status_bar_view.notice_label, text:text)
    # end

    # def show_activity_notice(text)
    #   position_label(@status_bar_view.activity_label, accessory:@status_bar_view.activity_spinner, text:text)
    #   show_notice_view(@status_bar_view.activity_view, notice_label:@status_bar_view.activity_label, text:text)
    #   @timer = EM.add_timer 3 { hide_status_bar_view }
    # end

    # def show_success_notice(text)
    #   position_label(@status_bar_view.success_label, accessory:@status_bar_view.success_image, text:text)
    #   show_notice_view(@status_bar_view.success_view, notice_label:@status_bar_view.success_label, text:text)
    #   @timer = EM.add_timer 3 { hide_status_bar_view }
    # end

    # def show_error_notice(text)
    #   position_label(@status_bar_view.error_label, accessory:@status_bar_view.error_image, text:text)
    #   show_notice_view(@status_bar_view.error_view, notice_label:@status_bar_view.error_label, text:text)
    #   @timer = EM.add_timer 3 { hide_status_bar_view }
    # end

    # def hide_notice
    #   hide_status_bar_view
    # end

    # def visible?
    #   view_visible?(@status_bar_view)
    # end



    # # INTERNAL COMMANDS
    # def show_status_bar_view
    #   if !visible?
    #     App.shared.setStatusBarHidden(true, withAnimation:UIStatusBarAnimationSlide)
    #     @status_bar_view.move_to([0, 0])
    #   end
    # end

    # def hide_status_bar_view
    #   if visible?
    #     @status_bar_view.move_to([0, 20])
    #     App.shared.setStatusBarHidden(false, withAnimation:UIStatusBarAnimationSlide)
    #   end
    # end

    # def show_notice_view(notice_view, notice_label:notice_label, text:text)
    #   EM.cancel_timer(@timer) unless @timer == nil
    #   clear_notices unless view_visible?(notice_view)
    #   notice_label.text = text
    #   notice_view.y = 0 if !visible?
    #   notice_view.move_to([0, 0]) if visible?
    #   show_status_bar_view unless visible?
    # end

    # def clear_notices
    #   @status_bar_view.subviews.each do |subview|
    #     next if subview.y != 0
    #     subview.move_to([0, -20]) { subview.y = 20 } if visible?
    #     subview.y = 20 if !visible?
    #   end
    # end

    # def view_visible?(view)
    #   view.y == 0
    # end

    # def position_label(label, accessory:accessory, text:text)
    #   label.restyle!
    #   label.x += 10
    #   accessory.x = StatusBar::Helper.accessory_x(text)
    # end

    # def rotate_status_bar
    #   ap "rotate_status_bar"
    #   ap "Device.interface_orientation: #{Device.interface_orientation}"
    #   @status_bar_view.restyle!(orientation = Device.interface_orientation)
    # end


    # # HELPER FUNCTIONS

    # def application_rotated(notification)
    #   return unless portrait? || landscape?
    #   return unless statusbar_view_visible?
    #   return if @old_orientation == Device.interface_orientation

    #   if @rotation_effect == "rotate"
    #     UIView.animation_chain {
    #       @statusbar_view.rotate_to(duration: 0.3, angle: degrees)
    #       @statusbar_view.frame = statusbar_view_frame(Device.interface_orientation)

    #       @statusbar_view.subviews.each do |view|
    #         view_frame = view.frame
    #         view_frame.size.width = statusbar_width
    #         view.width = statusbar_width
    #         view.move_to([0, 0])

    #         label_view = view.viewWithTag(1)
    #         accessory_view = view.viewWithTag(2)

    #         label_view.x = label_x(label_view.text) if label_view != nil
    #         accessory_view.x = accessory_x(label_view.text) if accessory_view != nil
    #         label_view.x += 10 if accessory_view != nil
    #       end
    #     }.start
    #   elsif @rotation_effect == "slide"
    #     slide_in_frame = hidden_statusbar_view_frame(@old_orientation)
    #     @statusbar_view.move_to([slide_in_frame.origin.x, slide_in_frame.origin.y])

    #     0.3.second.later {
    #       @statusbar_view.rotate_to(duration: 0.0, angle: degrees)
    #       @statusbar_view.frame = hidden_statusbar_view_frame(Device.interface_orientation)

    #       @statusbar_view.subviews.each do |view|
    #         view_frame = view.frame
    #         view_frame.size.width = statusbar_width
    #         view.width = statusbar_width
    #         view.move_to([0, 0])

    #         label_view = view.viewWithTag(1)
    #         accessory_view = view.viewWithTag(2)

    #         label_view.x = label_x(label_view.text) if label_view != nil
    #         accessory_view.x = accessory_x(label_view.text) if accessory_view != nil
    #         label_view.x += 10 if accessory_view != nil
    #       end

    #       0.1.second.later {
    #         UIView.animation_chain {
    #           @statusbar_view.frame = statusbar_view_frame(Device.interface_orientation)
    #         }.start
    #       }
    #     }
    #   end

    #   # Set old orientation to new orientation
    #   @old_orientation = Device.interface_orientation

    # end

  end

end