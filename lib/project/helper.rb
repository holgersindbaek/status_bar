module StatusBar
  class Helper
    
    class << self

      def label_color
        color = UIColor.blackColor
        case App.shared.statusBarStyle
        when UIStatusBarStyleDefault
          color = "#bcbcbc".uicolor unless HS::Base.ios_7?
        when UIStatusBarStyleLightContent
          color = "#ffffff".uicolor
        end
        return color
      end

      def label_font
        UIFont.boldSystemFontOfSize(HS::Base.ios_7? ? 12 : 14)
      end

      def label_alignment
        HS::Base.ios_6? ? UITextAlignmentCenter : NSTextAlignmentCenter
      end

      def textwidth(text)
        text.sizeWithFont(label_font).width
      end

      def accessory_x(text)
        (HS::Base.rotation_width/2) - (textwidth(text) / 2) - 10
      end

      def label_x(text)
        (HS::Base.rotation_width/2) - (textwidth(text) / 2)
      end
    
    end

  end
end