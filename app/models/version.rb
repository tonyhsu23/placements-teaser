class Version < ApplicationRecord
  include FieldSearchable

  belongs_to :user, foreign_key: 'whodunnit'
end
