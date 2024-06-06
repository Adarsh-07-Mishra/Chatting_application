class MessagesController < ApplicationController
  def create
    @current_user = current_user
    @message = @current_user.messages.create(content: format_message_content(msg_params[:content]), room_id: params[:room_id])

    respond_to do |format|
      if @message.persisted?
        format.json { render json: @message.as_json(include: :created_at), status: :created, location: @message }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def msg_params
    params.require(:message).permit(:content)
  end

  def format_message_content(content)
    words = content.split
    words.each_slice(10).map { |slice| slice.join(' ') }.join("\n")
  end
end
