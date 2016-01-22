require 'active_shipping'

class ShippingController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def ups_rates
    destination = location(params["destination"])
    origin = location(params["origin"])
    package = package(params["package"])
    ups = ActiveShipping::UPS.new(login: ENV['UPS_LOGIN'], password: ENV['UPS_PASSWORD'], key: ENV['UPS_ACCESS_KEY'])
    response = ups.find_rates(origin, destination, package)
    ups_rates = response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}
    render :json => ups_rates, :status => :ok
  end

  def fedex_rates
    destination = location(params["destination"])
    origin = location(params["origin"])
    package = package(params["package"])
    fedex = ActiveShipping::FedEx.new(login: ENV['FEDEX_LOGIN'], password: ENV['FEDEX_PASSWORD'], key: ENV['FEDEX_KEY'], account: ENV['FEDEX_ACCOUNT'], test: true)
    response = fedex.find_rates(origin, destination, package)
    fedex_rates = response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}
    render :json => fedex_rates, :status => :ok
  end

  private
    def location(loc_hash)
      ActiveShipping::Location.new(loc_hash)
    end

    def package(package_hash)
      weight = package_hash["weight"].to_i
      width = package_hash["width"].to_i
      length = package_hash["length"].to_i
      height = package_hash["height"].to_i
      cylinder = package_hash["cylinder"]
      return ActiveShipping::Package.new(weight, [length, width, height], cylinder: cylinder, units: :imperial)
    end
end
