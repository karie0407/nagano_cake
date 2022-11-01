class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!
  def create
    @address = Address.new(address_params)
    @address.customer = current_customer
    if @address.save
    redirect_to addresses_path
    else
      render :error
    end
  end
  def index
  @addresses =Address.all
  @address =Address.new
  end
  def edit
   @address =Address.find(params[:id])
  end
  def update
    address =Address.find(params[:id])
    if address.update(address_params)
    redirect_to addresses_path
    else
      render :edit
    end
  end

  def destroy
    address = Address.find(params[:id])
    address.destroy
    addresses = current_customer.addresses.all
    redirect_to addresses_path
  end

  private
  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end
end
