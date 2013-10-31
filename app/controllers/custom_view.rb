class CustomView < UIView

    def initWithFrame(frame)

      super.tap do
        self.stylesheet = :custom_view_sheet
        layout(self, :custom_view) do
          @notice_view = subview(UIView, :notice_view)
        end
      end

    end

end

Teacup::Stylesheet.new :custom_view_sheet do

  style :custom_view,
    width: 300,
    height: 400,
    left: 0,
    top: 0,
    backgroundColor: UIColor.blueColor
    
end