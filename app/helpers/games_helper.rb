module GamesHelper

    def image_for_game(game, size)
        unless game.image_file_name.blank?
          image_tag(game.image_file_name, size)
        end
    end

end
