class Host < ActiveRecord::Base
	has_many  :guests
end
