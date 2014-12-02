class RegisterController < ApplicationController
  def index
  end

	def check_in
		@params = params[:register]
		host_name = @params[:host_name]
		guest_name = @params[:guest_name]

		date_in = @params["date_in"].split("-")      
		@date_in = Date.new(date_in[0].to_i, date_in[1].to_i, date_in[2].to_i)            
		date_out = @params["date_out"].split("-")      
		@date_out = Date.new(date_out[0].to_i, date_out[1].to_i, date_out[2].to_i)      

		@host = Host.find_by_name(host_name)
		@guest = Guest.find_by_name(guest_name)

# 		Validations
		if @host == nil
			@note = 'Host not found. This host is not registered.'
			success = false
		elsif @guest == nil
			@note = 'Guest not found. This guest is not registered.'
			success = false		
		elsif @date_in > @date_out
			@note = 'Check out date should be greater or equal to the Check in date'
			success = false
		else
			date_begin = Date.new(date_in[0].to_i, date_in[1].to_i, 01)       		
			date_end = @date_in.end_of_month
			calc_days(@host.id, date_begin, date_end)			
			if @date_out < date_end
				date_end = @date_out
			end
			@total_overnights = @total_overnights + (date_end - @date_in).to_i
			if @total_overnights > 10
				@note = "This host has not days enough for overnight. This host has #{@balance} days left."
				success = false			
			end
		end	

		if success
			@check_in = CheckIn.create(host_id: @host.id, guest_id: @guest.id, date_in: @date_in, date_out: @date_out)
			@check_in.save
			success = true
			@note = 'The check in was completed.'
		end

		respond_to do |format|
			if success   
				format.html { render action: "check_in_success" }
			else
				format.html { render action: "check_in_error"}
			end
		end    
	end
	
	def list_check_in

	end	

	def list_result
		@params = params[:list_form]

		@host_name = @params[:host_name]
		@host = Host.find_by_name(@host_name)
		    
		date = @params["date"].split("-")      
		date_begin = Date.new(date[0].to_i, date[1].to_i)            
		date_end = date_begin.end_of_month		
		
		if @host != nil && date_begin != nil
			calc_days(@host.id, date_begin, date_end)			
		else
			@note = 'Fill all the required fields.'						
		end

		respond_to do |format|
			if @checks == nil
				@note = 'Host not found.'		
				format.html { render action: "list_error" }
			else
				format.html { render action: "list_result"}
			end
		end 				  		
	end

	def calc_days(host_id, date_begin, date_end)
		@checks = CheckIn.where("host_id = ? AND date(date_in) BETWEEN ? AND ?", host_id, date_begin, date_end)
		@total_overnights = 0			
		@checks.each do |i|
			@total_overnights = @total_overnights + (i.date_out - i.date_in).to_i
		end
		@balance = 10 - @total_overnights		
	end	
  
end
