class HomePageController < ApplicationController
  def index
  end
  
	def verify
		@params = params[:admin]
		admin = Admin.find_by_email(@params[:email])
		password = @params[:password]

		respond_to do |format|
			if admin and admin.authenticate(password)   
				format.html { redirect_to(home_page_index_url, notice: 'Authorized') }
			else
				format.html { render action: "login_error"}
			end
		end
	end

  
end
