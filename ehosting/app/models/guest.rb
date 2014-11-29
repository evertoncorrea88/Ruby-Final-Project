class Guest < ActiveRecord::Base
		has_many  :hosts
end
