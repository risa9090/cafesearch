class ShopsController < ApplicationController
    def index
    end

    def new
        @shop = Shop.new
    end

    def show
        @shop = Shop.find_by(id: params[:id])
    end

    def create
        @shop = Shop.new(shop_params)
        params[:shop][:question] ? @shop.question = params[:shop][:question].join("") : false
        if @shop.save
            flash[:notice] = "診断が完了しました"
            redirect_to shop_path(@shop.id)
        else
            redirect_to :action => "new"
        end
    end

private
    def shop_params
        params.require(:shop).permit(:id, :question1, :question2, :question3,:question4, question: [])
    end
end
