class CreateChats < ActiveRecord::Migration[5.0]
  def change
    create_table :chats do |t|
      t.string :title
      t.string :application_token,index:true
      t.references:applications,foreign_key:true
      t.integer:chat_number,index:true
      t.integer :messages_count,:default => 0

      t.timestamps
    end
  end
end
