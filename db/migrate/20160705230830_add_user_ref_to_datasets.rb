class AddUserRefToDatasets < ActiveRecord::Migration
  def change
    add_reference :datasets, :user, index: true, foreign_key: true
  end
end
