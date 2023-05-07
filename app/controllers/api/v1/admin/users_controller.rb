# frozen_string_literal: true

class Api::V1::Admin::UsersController < ApplicationController
  before_action :set_user, except: %i[index create]

  def index
    users = User.filter(params)
                .where('id != ?', @current_user.id)
                .with_attached_avatar

    paginate users,
             each_serializer: Admin::UsersSerializer,
             base_url: request.base_url
  end

  def show
    expose @user,
           serializer: Admin::UserSerializer,
           base_url: request.base_url
  end

  def create
    raise Errors::BadParameter, t(:wrong_password) unless @current_user.authenticate(user_params_updatable[:auth_password])

    User.create!(user_params.except(:auth_password))

    expose
  end

  def update
    raise Errors::BadParameter, t(:wrong_password) unless @current_user.authenticate(user_params_updatable[:auth_password])

    @user.update!(user_params_updatable.except(:auth_password))

    expose
  end

  private

  def user_params
    params.require(:user)
          .permit :email,
                  :password,
                  :role,
                  :birthday,
                  :firstname,
                  :lastname,
                  :auth_password
  end

  def user_params_updatable
    params.require(:user)
          .permit :role,
                  :locked,
                  :auth_password
  end

  def set_user
    @user = User.find_by!(email: params[:id])
  end
end
