class Course < ActiveRecord::Base
belongs_to :schedule
before_save { self.name = name.downcase }
end
