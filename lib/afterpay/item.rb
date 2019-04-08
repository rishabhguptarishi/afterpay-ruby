# frozen_string_literal: true

require "money"

module Afterpay
  class Item
    attr_accessor :name, :sku, :quantity, :price

    def initialize(name:, sku:, price:, quantity: 1)
      @name = name
      @sku = sku
      @quantity = quantity
      @price = price
    end

    def to_hash
      {
        name: name,
        sku: sku,
        quantity: quantity,
        price: {
          amount: price.to_f,
          currency: price.currency
        }
      }
    end

    # Builds Item from response
    def self.from_response(response)
      new(
        name: response["name"],
        sku: response["sku"],
        quantity: response["quantity"],
        price: Money.new(
          response.dig("price", "amount").to_f,
          response.dig("price", "currency")
        )
      )
    end
  end
end
