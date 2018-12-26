class CommentsController < ApplicationController

  before_action :auth_user

  def create
    @comment = current_user.comments.new(comment_params)
    product_id = params[:comment][:product_id]
    if @comment.save
      redirect_to product_path(product_id)
    else
      fetch_home_data
      @product = Product.find(product_id)
      render file: 'products/show'
    end
  end

  # todo
  def index
    # load data
    if request.xhr? #如果是异步请求
      @comments = current_user.comments.where(product_id: params[:product_id]).page(params[:page] || 1).per_page(params[:per_page] || 3)
        .order("id desc")

      render json: {
        status: :ok,
        msg: {
          html: render_to_string(partial: 'comments', layout: false),
          next_page: (@comments.blank? ? -1 : (@comments.next_page || -1))
        }
      }
      return
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :product_id)
  end

end
