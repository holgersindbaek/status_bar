module StatusBar
  class Base

    def initialize

      @status_bar_view = StatusBar::View.new
      App.shared.keyWindow.rootViewController.view.addSubview(@status_bar_view.view)
      App.shared.keyWindow.rootViewController.view.sendSubviewToBack(@status_bar_view.view)

      # Set old orientation and rotation effect
      @current_notice_view = nil
      @timer = nil

      # Listen for rotation
      App.notification_center.observe UIDeviceOrientationDidChangeNotification do |notification|
        UIView.animate do
          position_inner_views(@current_notice_view) unless @current_notice_view == nil
        end
      end
    end



    # EXTERNAL COMMANDS
    def show_notice(text)
      show_notice_view(@status_bar_view.notice_view, text:text)
    end

    def show_activity_notice(text)
      show_notice_view(@status_bar_view.activity_view, text:text)
    end

    def show_success_notice(text)
      show_notice_view(@status_bar_view.success_view, text:text)
    end

    def show_error_notice(text)
      show_notice_view(@status_bar_view.error_view, text:text)
    end

    def hide_notice
      hide_status_bar_view
    end

    def visible?
      StatusBar::Helper.view_visible?(@status_bar_view.status_bar_view)
    end



    # INTERNAL COMMANDS
    def show_status_bar_view
      if !visible?
        App.shared.setStatusBarHidden(true, withAnimation:UIStatusBarAnimationSlide)
        @status_bar_view.status_bar_view.move_to([0, 0])
      end
    end

    def hide_status_bar_view
      if visible?
        @status_bar_view.status_bar_view.move_to([0, 20])
        App.shared.setStatusBarHidden(false, withAnimation:UIStatusBarAnimationSlide)
      end
    end

    def show_notice_view(notice_view, text:text)
      label = StatusBar::Helper.label(notice_view)
      accessory = StatusBar::Helper.accessory(notice_view)

      EM.cancel_timer(@timer) unless @timer == nil
      clear_notice_view(@current_notice_view) unless StatusBar::Helper.view_visible?(notice_view)

      label.text = text
      notice_view.y = 0 if !visible?
      notice_view.move_to([0, 0]) if visible?
      position_inner_views(notice_view)
      @timer = EM.add_timer 13 { hide_status_bar_view } unless accessory == nil

      show_status_bar_view unless visible?
      @current_notice_view = notice_view
    end

    def clear_notice_view(view)
      return if view == nil
      view.move_to([0, -20]) { view.y = 20 } if visible?
      view.y = 20 if !visible?
    end

    def position_inner_views(view)
      label = StatusBar::Helper.label(view)
      accessory = StatusBar::Helper.accessory(view)

      return if accessory == nil
      ap label.text
      label.restyle!
      label.x += 10
      accessory.x = StatusBar::Helper.accessory_x(label.text)
    end

  end
end