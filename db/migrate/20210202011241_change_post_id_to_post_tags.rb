class ChangePostIdToPostTags < ActiveRecord::Migration[5.2]
  def change
    change_column :post_tags, :post_id, :integer, null: false
  end
end
