class ItemsController < ApplicationController
    def index 
        @supermarket = Supermarket.find(params[:id])
    end
end