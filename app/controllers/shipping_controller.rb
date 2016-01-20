require 'active_shipping'

class ShippingController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def location(loc_hash)
    ActiveShipping::Location.new(loc_hash)
  end

  # def destination
  #   ActiveShipping::Location.new(country: "US", state: "CA", city: "Los Angeles", postal_code: "90024")
  # end

  def package(package_hash)
    weight = package_hash["weight"]
    width = package_hash["width"]
    length = package_hash["length"]
    height = package_hash["height"]
    cylinder = package_hash["cylinder"]
    # package = Package.new(weight, [length, width, height], cylinder: cylinder)
    return ActiveShipping::Package.new(weight, [length, width, height], cylinder: cylinder)
  end

  def ups_rates
    destination = location(params["destination"])
    origin = location(params["origin"])
    package = package(params["package"])
    ups = ActiveShipping::UPS.new(login: ENV['UPS_LOGIN'], password: ENV['UPS_PASSWORD'], key: ENV['UPS_ACCESS_KEY'])
    response = ups.find_rates(origin, destination, package)
    ups_rates = response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}
    render :json => ups_rates
  end

  def fedex_rates
    destination = location(params["destination"])
    origin = location(params["origin"])
    package = package(params["package"])
    fedex = ActiveShipping::FedEx.new(login: ENV['FEDEX_LOGIN'], password: ENV['FEDEX_PASSWORD'], key: ENV['FEDEX_KEY'], account: ENV['FEDEX_ACCOUNT'], test: true)
    response = fedex.find_rates(origin, destination, packages)
    fedex_rates = response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}
    render :json => fedex_rates
  end

end
