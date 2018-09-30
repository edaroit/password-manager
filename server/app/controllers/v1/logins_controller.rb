# frozen_string_literal: true

module V1
  class LoginsController < ApplicationController
    before_action :set_login, only: %i[show update destroy]

    def index
      @logins = current_user.logins
      json_response(@logins)
    end

    def create
      @login = current_user.logins.create!(login_params)
      json_response(@login, :created)
    end

    def show
      json_response(@login)
    end

    def update
      @login.update(login_params)
      head :no_content
    end

    def destroy
      @login.destroy
      head :no_content
    end

    private

    def login_params
      params.permit(:username, :password, :site)
    end

    def set_login
      @login = Login.find(params[:id])
    end
  end
end
