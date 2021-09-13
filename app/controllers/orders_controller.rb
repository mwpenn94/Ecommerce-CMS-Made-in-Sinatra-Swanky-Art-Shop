require "active_merchant/billing/rails"

class OrdersController < ApplicationController
    
  get '/orders' do
    validate_user_auth
    @orders = Order.where(user_id: current_user)
    erb :'orders/orders'
  end
  
  get '/orders/new' do
    validate_user_auth
    erb :'orders/create_order'
  end
  
  post '/orders' do
    validate_user_auth
    if params == ""
      redirect to "/orders/new"
    else
      credit_card = ActiveMerchant::Billing::CreditCard.new(
        :number     => params[:card_number],
        :month      => params[:card_expiration_date].split("-")[1],
        :year       => params[:card_expiration_date].split("-")[0],
        :first_name => params[:bill_firstname],
        :last_name  => params[:bill_lastname],
        :verification_value  =>  params[:card_verification]
        )
        if credit_card.valid?
          gateway = ActiveMerchant::Billing::TrustCommerceGateway.new(
            :login    => 'TestMerchant',
            :password => 'password'
            )
            response = gateway.authorize(1000, credit_card)
             if response.success?
              gateway.capture(1000, response.authorization)
              @order = current_user.orders.build(card_number: params[:card_number], card_expiration_date: params[:card_expiration_date], card_verification: params[:card_verification], bill_firstname: params[:bill_firstname], bill_lastname: params[:bill_lastname], bill_address1: params[:bill_address1], bill_address2: params[:bill_address2], bill_city: params[:bill_city], bill_state: params[:bill_state], bill_zipcode: params[:bill_zipcode], ship_firstname: params[:ship_firstname], ship_lastname: params[:ship_lastname], ship_address1: params[:ship_address1], ship_address2: params[:ship_address2], ship_city: params[:ship_city], ship_state: params[:ship_state], ship_zipcode: params[:ship_zipcode], phone: params[:phone]) 
                if @order.save
                  redirect to "/orders/#{@order.id}"
                else
                  flash[:error] = "Please enter information to resolve the following errors: #{credit_card.validate}"
                  redirect to "/orders/new"
                end
            else
              flash[:error] = "Insufficient funds. Please enter a different payment method."
            end
          else
            flash[:error] = "Please enter information to resolve the following errors: #{credit_card.validate}"
            redirect to "/orders/new"
          end
    end
  end

  get '/orders/:id' do
    validate_user_auth
    @order = Order.find_by_id(params[:id])
    erb :'orders/show_order'
  end
  
  get '/orders/:id/edit' do
    validate_user_auth
    @order = Order.find_by_id(params[:id])
      if @order && @order.user == current_user
        erb :'orders/edit_order'
      else
        redirect to '/orders'
      end
  end
  
  patch '/orders/:id' do
    validate_user_auth
    if params[:content] == ""
      redirect to "/orders/#{params[:id]}/edit"
    else
      @order = Order.find_by_id(params[:id])
      if @order && @order.user == current_user
        credit_card = ActiveMerchant::Billing::CreditCard.new(
          :number     => params[:card_number],
          :month      => params[:card_expiration_date].split("-")[1],
          :year       => params[:card_expiration_date].split("-")[0],
          :first_name => params[:bill_firstname],
          :last_name  => params[:bill_lastname],
          :verification_value  =>  params[:card_verification]
          )
          if credit_card.valid?
            gateway = ActiveMerchant::Billing::TrustCommerceGateway.new(
              :login    => 'TestMerchant',
              :password => 'password'
              )
              response = gateway.authorize(1000, credit_card)
              if response.success?
                gateway.capture(1000, response.authorization)
                @order.update(card_number: params[:card_number], card_expiration_date: params[:card_expiration_date], card_verification: params[:card_verification], bill_firstname: params[:bill_firstname], bill_lastname: params[:bill_lastname], bill_address1: params[:bill_address1], bill_address2: params[:bill_address2], bill_city: params[:bill_city], bill_state: params[:bill_state], bill_zipcode: params[:bill_zipcode])
                redirect to "/orders/#{@order.id}"
              else
                flash[:error] = "Insufficient funds. Please enter a different payment method."
                redirect to "/orders/#{@order.id}/edit"
              end
          else
            flash[:error] = "Please enter information to resolve the following errors: #{credit_card.validate}"
            redirect to "/orders/#{@order.id}/edit"
          end 
      end
    end
  end

    delete '/orders/:id/delete' do
      validate_user_auth
        @order = Order.find_by_id(params[:id])
        if @order && @order.user == current_user
          @order.delete
        end
        redirect to '/orders'
    end

    private 


  def validate_user_auth
    redirect to '/login' unless logged_in?
  end
end