class AddAttachmentImageToBoards < ActiveRecord::Migration
  def self.up
    change_table :boards do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :boards, :image
  end
end
