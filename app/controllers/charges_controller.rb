class ChargesController < ApplicationController
    def create
      @product = Product.find(params[:product_id])
      @amount = @product.price * 100
  
      customer = Stripe::Customer.create(
        email: params[:stripeEmail],
        source: params[:stripeToken]
      )
  
      charge = Stripe::Charge.create(
        customer: customer.id,
        amount: @amount,
        description: @product.name,
        currency: 'usd'
      )
  
      flash[:success] = "Payment successful!"
      redirect_to product_path(@product)
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to product_path(@product)
    end
end
