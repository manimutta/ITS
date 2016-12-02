class CommentsController < ApplicationController
   def create
    @comment = Comment.new(
      comment: params[:comment][:comment],
      ticket_id: params[:id],
      user_id: current_user.id
      )
    @comment.save
    redirect_to @comment.ticket, notice: 'Ticket was successfully created.'
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to @comment.ticket, notice: 'Ticket was successfully created.'
  end
end
