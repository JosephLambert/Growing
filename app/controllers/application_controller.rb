class ApplicationController < ActionController::Base

  self.wechat_gate_app_name = 'eggman'

  protect_from_forgery with: :exception

  before_action :set_browser_uuid

  protected
  def auth_user
    unless logged_in?
      flash[:notice] = "请登录"
      redirect_to new_session_path
    end
  end

  # def logged_in?
  #   !session[:user_id].blank?
  # end

  # def current_user
  #   if logged_in?
  #     @current_user ||= User.find(session[:user_id])
  #   else
  #     nil
  #   end
  # end

  def fetch_home_data
    @categories = Category.grouped_data
    @shopping_cart_count = ShoppingCart.by_user_uuid(session[:user_uuid]).count
  end

  def set_browser_uuid
    uuid = cookies[:user_uuid]

    unless uuid
      if logged_in?
        uuid = current_user.uuid
      else
        uuid = RandomCode.generate_utoken
      end
    end

    update_browser_uuid uuid
  end

  def update_browser_uuid uuid
    session[:user_uuid] = cookies.permanent['user_uuid'] = uuid
  end
end
