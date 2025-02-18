class Public::PostCommentsController < ApplicationController
    before_action :require_access_time

def create
    post = Post.find(params[:post_id])
    post_comment = current_user.post_comments.new(post_comment_params)
    post_comment.post_id = post.id
    if post_comment.save
      post.create_notification_post_comment!(current_user, post_comment.id)
    end
      redirect_to post_path(post)
end

 def destroy
    PostComment.find(params[:id]).destroy
    redirect_to post_path(params[:post_id])
 end


private

def post_comment_params
    params.require(:post_comment).permit(:comment)
end

def require_access_time
    if 23 <= Time.current.hour || Time.current.hour <= 5
      redirect_to times_path
    end
end

end
