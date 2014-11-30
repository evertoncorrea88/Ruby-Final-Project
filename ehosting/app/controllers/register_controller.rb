class RegisterController < ApplicationController
  def index
  end

  def check_in
      @params = params[:register]
      host_name = @params[:host_name]
      guest_name = @params[:guest_name]
      date_in = @params[:date_in]
      date_out = @params[:date_out]
      
      @host = Host.find_by_name(host_name)
      @guest = Guest.find_by_name(guest_name)

      if @host == nil
          @note = 'This host is not registered.'
      elsif @guest == nil
          @note = 'This guest is not registered.'
      else
          @check_in = CheckIn.create(host_id: @host.id, guest_id: @guest.id, date_in: date_in, date_out: date_out)
          @check_in.save
          success = true
          @note = 'The check in was completed.'
      end
      
      respond_to do |format|
          if success   
			format.html { render action: "check_in" }
		  else
			format.html { render action: "check_in_error"}
		  end
      end    
  end

  def list_check_in
  end
end
