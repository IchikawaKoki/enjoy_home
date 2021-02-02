class ChangeTagIdToPostTags < ActiveRecord::Migration[5.2]
  def change
    change_column :post_tags, :tag_id, :integer, null: false
  end
end
