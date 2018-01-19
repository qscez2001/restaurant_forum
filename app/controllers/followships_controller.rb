class FollowshipsController < ApplicationController
  
  def create
    # 由於 params[:following_id] 會回傳一個數字，因此在指定參數時，需要使用 following_id 這個選項。

    @followship = current_user.followships.build(following_id: params[:following_id])

    if @followship.save
      flash[:notice] = "Successfully followed"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = @followship.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    end
  end

end
