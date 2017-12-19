class CreateNewposts < ActiveRecord::Migration
  def change
    create_table :newposts do |t|
############################################

t.string :title
# column이 title이라는 string을 만든다.
t.string :contents
# column이 contents이라는 string을 만든다.

############################################
      t.timestamps 
      # null: false
    end
  end
end
