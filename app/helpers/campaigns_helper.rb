module CampaignsHelper

    def image_for_campaign(campaign, size)
        if campaign.image_file_name.blank?
          image_tag('d20.png', size)
        else
          image_tag(campaign.image_file_name, size)
        end
    end

end
