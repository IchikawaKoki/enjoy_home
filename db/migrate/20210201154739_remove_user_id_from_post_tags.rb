class RemoveUserIdFromPostTags < ActiveRecord::Migration[5.2]
  def change
    remove_column :post_tags, :user_id, :integer
  end
end
