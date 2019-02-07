# frozen_string_literal: true

# Copyright 2018 Bryan Knouse, Magus Pereira, Charlie Evans, Taraqur Rahman,
# Nick Feuer
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# MessagesController
class MessagesController < ApplicationController
  def index
    @user = current_user
    @message = Message.new
    @messages = Message.where('sender = ? OR recipient = ?', @user.id, @user.id)
                       .order(created_at: :desc)
  end

  def show; end

  def new
    @message = Message.new
  end

  def edit; end

  def create
    @message = Message.new(message_params)

    respond_to do |format|
      if @message.save
        format.html do
          redirect_to '/messages', notice: 'Message created.'
        end
        format.json do
          render action: 'show', status: :created, location: @message
        end
      else
        format.html do
          render action: 'new'
        end
        format.json do
          render json: @message.errors, status: :unprocessable_entity
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html do
          redirect_to @message, notice: 'Message was successfully updated.'
        end
        format.json do
          render :show, status: :ok, location: @message
        end
      else
        format.html do
          redirect_to @message
        end
        format.json do
          render json: @message.errors, status: :unprocessable_entity
        end
      end
    end
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    respond_to do |format|
      format.html do
        redirect_to '/messages', notice: 'Message was successfully destroyed.'
      end
      format.json do
        head :no_content
      end
    end
  end

  private

  def message_params
    params.require(:message)
          .permit(:sender, :recipient, :message, :file, :read, :mtype)
  end
end
