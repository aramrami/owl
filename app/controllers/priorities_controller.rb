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

# PrioritiesController
class PrioritiesController < ApplicationController
  def index
    @priorities = Priority.all
    @newpriority = Priority.new
  end

  def show; end

  def new
    @priority = Priority.new
  end

  def edit; end

  def create
    @priority = Priority.new(priority_params)

    respond_to do |format|
      if @priority.save
        format.html do
          redirect_to '/priorities', notice: 'Priority created.'
        end
        format.json do
          render action: 'show', status: :created, location: @priority
        end
      else
        format.html do
          render action: 'new'
        end
        format.json do
          render json: @priority.errors, status: :unprocessable_entity
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @priority.update(priority_params)
        format.html do
          redirect_to @priority, notice: 'Priority was successfully updated.'
        end
        format.json do
          render :show, status: :ok, location: @priority
        end
      else
        format.html do
          redirect_to @priority
        end
        format.json do
          render json: @priority.errors, status: :unprocessable_entity
        end
      end
    end
  end

  def destroy
    @priority = Priority.find(params[:id])
    @priority.destroy
    respond_to do |format|
      format.html do
        redirect_to '/prioritys', notice: 'priority was successfully destroyed.'
      end
      format.json do
        head :no_content
      end
    end
  end

  private

  def priority_params
    params.require(:priority).permit(:name, :details, :level, :incident_id)
  end
end
