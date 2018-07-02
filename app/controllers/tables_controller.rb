class TablesController < ApplicationController
  before_action :set_table, only: [:show, :update, :destroy]
  before_action :set_restaurant, only: [:index, :create]

  def index
    @tables = @restaurant.tables
    json_response(@tables)
  end

  def create
    @table = @restaurant.tables.create!(table_params)
    json_response(@table, :created)
  end

  def show
    json_response(@table)
  end

  def update
    @table.update(table_params)
  end

  def destroy
    @table.destroy
    head :no_content
  end

  def table_params
    params.permit(:name, :min_guest, :max_guest)
  end

  def set_table
    @table = Table.find(params[:id])
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end
end
