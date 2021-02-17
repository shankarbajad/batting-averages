require 'csv'

namespace :import do
  desc "Import teams from csv file"
  task import: :environment do
  	file = "public/Batting.csv"
  	teams_csv = CSV.read( "public/Teams.csv", :headers => true)
  	batting_csv = CSV.read( "public/Batting.csv", :headers => true)
  	CSV.foreach(file, :headers => true) do |row|
	    name = teams_csv.find {|team| team['teamID'] == row["teamID"]}["name"]
	    player_records =batting_csv.find_all{|batting | batting["playerID"] == row["playerID"] && batting["yearID"] == row["yearID"]}
	    player_h_record = player_records.pluck("H").map(&:to_i).sum
	    player_ab_record = player_records.pluck("AB").map(&:to_i).sum
	    batting_averag = player_h_record.to_f/player_ab_record.to_f
	    next if BattingRecord.find_by(playerID: row["playerID"], yearId: row["yearID"])
	    batting_record = BattingRecord.create(playerID: row["playerID"], yearId: row["yearID"], team_name: name, batting_averag: batting_averag)
	  end
  end

end
