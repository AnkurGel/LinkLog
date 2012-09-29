class AddImportantToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :important, :boolean, default: false
  end
end
