class Course < ActiveRecord::Base

  belongs_to :teacherbook
  has_many :notes, :modifyparagraphs

end
