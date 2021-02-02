class AddTagIdToPostTags < ActiveRecord::Migration[5.2]
  def change
    add_column :post_tags, :tag_id, :integer
  end
end
