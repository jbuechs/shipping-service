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
    package = ActiveShipping::Package.new(100,[93,10],cylinder: true)
  end

  def ups_rates
    ups = ActiveShipping::UPS.new(login: ENV['UPS_LOGIN'], password: ENV['UPS_PASSWORD'], key: ENV['UPS_ACCESS_KEY'])
    response = get_rates_from_shipper(ups)
    rate_array = []
    response.each do |rate_estimate|
      shipping_option = rate_estimate.service_name
      price = rate_estimate.total_price
      rate_array << {shipping_option => price}
    end
    render :json => rate_array
  end

  def fedex_rates
    fedex = ActiveShipping::FedEx.new(login: ENV['FEDEX_LOGIN'], password: ENV['FEDEX_PASSWORD'], key: ENV['FEDEX_KEY'], account: ENV['FEDEX_ACCOUNT'], test: true)
    response = get_rates_from_shipper(fedex)
    rate_array = []
    response.each do |rate_estimate|
      shipping_option = rate_estimate.service_name
      price = rate_estimate.total_price
      rate_array << {shipping_option => price}
    end
    render :json => rate_array
  end

  def get_rates_from_shipper(shipper)
    response = shipper.find_rates(origin, destination, packages)
    response.rates.sort_by(&:price)
  end
end
