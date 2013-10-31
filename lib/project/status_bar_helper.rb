module StatusBar
  class Helper
    
    class << self

      def text_color
        local_color = UIColor.blackColor
        case App.shared.statusBarStyle
        when UIStatusBarStyleDefault, UIStatusBarStyleBlackTranslucent, UIStatusBarStyleBlackOpaque
          local_color = "#bcbcbc".uicolor unless ios_7?
        when UIStatusBarStyleLightContent
          local_color = "#ffffff".uicolor
        end
          return local_color
      end

    end

  end
end