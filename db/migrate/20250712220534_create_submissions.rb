class CreateSubmissions < ActiveRecord::Migration[8.0]
  def change
    create_table :submissions do |t|
      t.string :title
      t.uuid :s_id
      t.string :description
      t.string :genre
      t.string :platforms
      t.string :demo_url
      t.string :status
      t.string :version
      t.string :visibility

      t.timestamps
    end
  end
end
