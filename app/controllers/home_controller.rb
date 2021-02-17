class HomeController < ApplicationController
  def index
  	@batting_records = BattingRecord.all
  	if params[:yearId].present? && params[:team_name].present?
  		@batting_records = BattingRecord.where(yearId: params[:yearId],team_name: params[:team_name])
  	elsif params[:yearId].present? || params[:team_name].present?
  		@batting_records = BattingRecord.where('yearId = ? OR team_name = ?',params[:yearId] , params[:team_name])
  	end
  end
end
