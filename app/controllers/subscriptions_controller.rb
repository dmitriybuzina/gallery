class SubscriptionsController < ApplicationController

  def new
    @subscription = Subscription.new
    @subscription.category_id = params[:category_id]
    @subscription.user_id = current_user.id
  end

  def create
    @subscription = Subscription.new(subscription_params)
    @subscription.category_id = params[:category_id]
    @subscription.user_id = current_user.id
    @subscription.save
  end
  private
  def subscription_params
    params.require(:subscription).permit(:user_id, :category_id)
  end
end
