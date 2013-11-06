describe "A - DemoController" do
  tests DemoController

  before do
    # Buttons
    @show_notice_button = view("Show Notice")
    @show_activity_button = view("Show Activity")
    @show_success_button = view("Show Success")
    @show_error_button = view("Show Error")
    @hide_notice_button = view("Hide Notice")
    @visibility_button = view("Visible?")

    # Statusbar view
    @status_bar_view = controller.view.viewWithStylename(:status_bar_view)

    # Statusbar subviews
    @notice_view = controller.view.viewWithStylename(:notice_view)
    @notice_label = controller.view.viewWithStylename(:notice_label)
    @activity_view = controller.view.viewWithStylename(:activity_view)
    @activity_spinner = controller.view.viewWithStylename(:activity_spinner)
    @activity_label = controller.view.viewWithStylename(:activity_label)
    @success_view = controller.view.viewWithStylename(:success_view)
    @success_image = controller.view.viewWithStylename(:success_image)
    @success_label = controller.view.viewWithStylename(:success_label)
    @error_view = controller.view.viewWithStylename(:error_view)
    @error_image = controller.view.viewWithStylename(:error_image)
    @error_label = controller.view.viewWithStylename(:error_label)
  end



  context "B - View existence" do

    it "buttons" do
      @show_notice_button.should.not.equal nil
      @show_activity_button.should.not.equal nil
      @show_success_button.should.not.equal nil
      @show_error_button.should.not.equal nil
      @hide_notice_button.should.not.equal nil
      @visibility_button.should.not.equal nil
    end

    it "statusbar view" do
      @status_bar_view.should.not.equal nil
    end

    it "statusbar subviews" do
      @notice_view.should.not.equal nil
      @notice_label.should.not.equal nil
      @activity_view.should.not.equal nil
      @activity_spinner.should.not.equal nil
      @activity_label.should.not.equal nil
      @success_view.should.not.equal nil
      @success_image.should.not.equal nil
      @success_label.should.not.equal nil
      @error_view.should.not.equal nil
      @error_image.should.not.equal nil
      @error_label.should.not.equal nil
    end

  end



  context "B - Clicking buttons" do

    it "show notice" do
      @notice_view.y.should.equal 20
      tap "Show Notice"
      wait 0.3 do
        @notice_view.y.should.equal 0
      end
    end

    it "activity notice" do
      @activity_view.y.should.equal 20
      tap "Show Activity"
      wait 0.3 do
        @activity_view.y.should.equal 0
      end
    end

    it "success notice" do
      @success_view.y.should.equal 20
      tap "Show Success"
      wait 0.3 do
        @success_view.y.should.equal 0
      end
    end

    it "error notice" do
      @error_view.y.should.equal 20
      tap "Show Error"
      wait 0.3 do
        @error_view.y.should.equal 0
      end
    end

    it "hide notice" do
      @status_bar_view.y.should.equal 0
      tap "Hide Notice"
      wait 0.3 do
        @status_bar_view.y.should.equal 20
      end
    end

  end



  context "B - Multiple clicks" do

    it "show success notice three times" do
      @success_view.y.should.equal 20
      tap "Show Success"
      wait 0.3 do
        tap "Show Success"
        @success_view.y.should.equal 0
      end

      wait 0.4 do
        tap "Show Success"
        @success_view.y.should.equal 0
      end

      wait 0.5 do
        @success_view.y.should.equal 0
      end
    end

    it "show success notice twice with different message" do
      @notice_view.y.should.equal 20
      tap "Show Notice"
      wait 0.3 do
        @notice_view.y.should.equal 0
        @notice_label.text.should.equal "This is a notice"
        controller.status_bar.show_notice "This is another notice"
      end

      wait 0.4 do
        @notice_view.y.should.equal 0
        @notice_label.text.should.equal "This is another notice"
      end
    end

    it "show success, then notice, then error" do
      @success_view.y.should.equal 20
      tap "Show Success"
      wait 0.3 do
        @success_view.y.should.equal 0
        tap "Show Notice"
      end

      wait 0.4 do
        @notice_view.y.should < 20
        tap "Show Error"
      end

      wait 0.5 do
        @error_view.y.should < 20
      end
    end

  end


end
