class AddUserToPhotos < ActiveRecord::Migration[6.0]
  def change
    add_reference :photos, :user, type: :uuid, null: false, foreign_key: true
  end
end
