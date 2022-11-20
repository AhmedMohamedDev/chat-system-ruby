class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.integer :message_chat_number,index:true
      t.references:chats,foreign_key:true
      t.string :message
      t.integer :message_number

      t.timestamps
    end
    add_index :messages, :message_number
  end
end
