module StatusBar
  class View < UIViewController
    stylesheet :status_bar_style

    attr_accessor :status_bar_view, :notice_view, :notice_label, :activity_view, :activity_spinner, :activity_label, :success_view, :success_image, :success_label, :error_view, :error_image, :error_label

    layout :status_bar_view_controller do
      
      @status_bar_view = subview(UIView, :status_bar_view) do
        @notice_view = subview(UIView, :notice_view) do
          @notice_label = subview(UILabel, :notice_label)
        end

        @activity_view = subview(UIView, :activity_view) do
          @activity_spinner = subview(UIActivityIndicatorView, :activity_spinner).startAnimating
          @activity_label = subview(UILabel, :activity_label)
        end

        @success_view = subview(UIView, :success_view) do
          @success_image = subview(UIImageView, :success_image)
          @success_label = subview(UILabel, :success_label)
        end

        @error_view = subview(UIView, :error_view) do
          @error_image = subview(UIImageView, :error_image)
          @error_label = subview(UILabel, :error_label)
        end
      end
      
    end

    def viewDidLoad
      super 
    end
    
  end

end