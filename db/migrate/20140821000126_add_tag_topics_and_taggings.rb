class AddTagTopicsAndTaggings < ActiveRecord::Migration
  def change
    create_table :tag_topics do |t|
      t.string :tag_name, null: false
      t.timestamps
    end
    
    create_table :taggings do |t|
      t.integer :tag_topic_id, null: false
      t.integer :shortened_url_id, null: false
      t.timestamps
    end
    
     add_index(:tag_topics, :tag_name)
     add_index(:taggings, :tag_topic_id)
     add_index(:taggings, :shortened_url_id)
  end
end
