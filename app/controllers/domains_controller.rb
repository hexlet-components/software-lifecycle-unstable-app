# frozen_string_literal: true

require 'net/http'

class DomainsController < ApplicationController
  def create
    domain_name = domain_params[:name]

    if domain_name.empty?
      flash.now[:error] = 'Укажите адрес'
      render 'root/index', status: :unprocessable_entity
      return
    end
    uri = URI(domain_params[:name])
    response = Net::HTTP.get_response(uri)

    if fail?
      raise 'Упс! Что-то пошло не так'
    end

    if response.is_a?(Net::HTTPSuccess)
      redirect_to :root, { notice: 'Ура! Сайт успешно проверен и никакой ошибки не произошло' }
      return
    end

    redirect_to :root, flash: { error: 'Упс! Кажется сайт не отвечает' }
  end

  private

  def domain_params
    params.require(:domain).permit(:name)
  end

  def fail?
    rand(1..5) == 5
  end
end
