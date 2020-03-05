module ApplicationHelper

    def auth_check 
        redirect_to(root_url) unless current_user.admin? || current_user == @event.creator
    end

    def model_date(model)
        if model.updated_at > model.created_at
            "Created: #{model.created_at} | Updated: #{model.updated_at}"
        else  
            "Created: #{model.created_at}"
        end
    end
end
