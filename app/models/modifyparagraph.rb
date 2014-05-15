class Modifyparagraph < ActiveRecord::Base

  belongs_to :course
  belongs_to :chapter
  belongs_to :paragraph

end
