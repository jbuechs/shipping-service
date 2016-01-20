require 'active_shipping'

class ShippingController < ApplicationController
  def origin
    ActiveShipping::Location.new(country: "US", state: "WA", city: "Seattle", postal_code: "98102")
  end

  def destination
    ActiveShipping::Location.new(country: "US", state: "CA", city: "Los Angeles", postal_code: "90024")
  end

  def packages
    # package = Package.new(weight, [length, width, height], cylinder: cylinder)
    return ActiveShipping::Package.new(100,[93,10],cylinder: true)
  end

  def ups_rates
    ups = ActiveShipping::UPS.new(login: ENV['UPS_LOGIN'], password: ENV['UPS_PASSWORD'], key: ENV['UPS_ACCESS_KEY'])
    response = ups.find_rates(origin, destination, packages)
    ups_rates = response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}
    render :json => ups_rates
  end

  def fedex_rates
    fedex = ActiveShipping::FedEx.new(login: ENV['FEDEX_LOGIN'], password: ENV['FEDEX_PASSWORD'], key: ENV['FEDEX_KEY'], account: ENV['FEDEX_ACCOUNT'], test: true)
    response = fedex.find_rates(origin, destination, packages)
    fedex_rates = response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}
    render :json => fedex_rates
  end
  
end
