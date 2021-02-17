class CreateBattingRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :batting_records do |t|
      t.string :playerID
      t.integer :yearId
      t.string :team_name
      t.decimal :batting_averag, :precision => 4, :scale => 3, null: false

      t.timestamps
    end
  end
end
