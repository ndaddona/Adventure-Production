class GamesController < ApplicationController
    
    before_action :set_campaign
    before_action :require_signin, except: [:index, :show]
    before_action :require_correct_or_admin, except: [:index, :show]

    def index
        @games = @campaign.games
        if params[:search]
            @games = @campaign.games.search(params[:search])
        end
    end

    def show
        @game = @campaign.games.find(params[:id])
    end


    def new
        @game = @campaign.games.new
    end

    def create
        @game = @campaign.games.new(game_params)
        if @game.save
            redirect_to @campaign
        else
            render :new
        end
    end

    def edit
        @game = @campaign.games.find(params[:id])
    end

    def update
        @game = @campaign.games.find(params[:id])
        if @game.update(game_params)
            redirect_to campaign_game_path
        else
            render :edit
        end
    end

    def destroy
        @game = @campaign.games.find(params[:id])
        @game.destroy
        redirect_to @campaign
    end

    private

    def game_params
        params.require(:game).permit(:title,:description, :image_file_name)
    end

    def set_campaign
        @campaign = Campaign.find(params[:campaign_id])
    end

    def require_correct_or_admin
        unless current_user?(@campaign.user) || current_user.admin?
          redirect_to root_url
        end
    end


end
