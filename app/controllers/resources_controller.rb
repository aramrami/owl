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

# ResourceController
class ResourcesController < ApplicationController
  def index
    @user = current_user
    @resource = Resource.new
    @resources = Resource.all
  end

  def show
    @resource = Resource.find(params[:id])
  end

  def new
    @resource = Resource.new
  end

  def edit; end

  def create
    @resource = Resource.new(resource_params)

    respond_to do |format|
      if @resource.save
        format.html do
          redirect_to '/resources', notice: 'resource created.'
        end
        format.json do
          render action: 'show', status: :created, location: @resource
        end
      else
        format.html do
          render action: 'new'
        end
        format.json do
          render json: @resource.errors, status: :unprocessable_entity
        end
      end
    end
  end

  def update
    @resource = Resource.find(params[:id])
    respond_to do |format|
      if @resource.update(resource_params)
        format.html do
          redirect_to @resource, notice: 'resource was successfully updated.'
        end
        format.json do
          render :show, status: :ok, location: @resource
        end
      else
        format.html do
          redirect_to @resource
        end
        format.json do
          render json: @resource.errors, status: :unprocessable_entity
        end
      end
    end
  end

  def destroy
    @resource = resource.find(params[:id])
    @resource.destroy
    respond_to do |format|
      format.html do
        redirect_to '/resources', notice: 'resource was successfully destroyed.'
      end
      format.json do
        head :no_content
      end
    end
  end

  private

  def resource_params
    params.require(:resource).permit(:name, :quantity, :location)
  end
end
