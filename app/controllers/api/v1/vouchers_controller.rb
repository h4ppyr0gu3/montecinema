module Api
  module V1
    class VouchersController < ApplicationController
      def index
        vouchers = ::Vouchers::UseCases::Index.new(params).call
        render json: ::Vouchers::Representers::Multiple.new(vouchers).call
      end

      def show
        voucher = ::Vouchers::UseCases::Show.new(params[:id]).call
        authorize([:api, :v1, voucher])
        render json: ::Vouchers::Representers::Single.new(voucher).call
      end

      def create
        voucher = ::Vouchers::Model.new
        authorize([:api, :v1, voucher])
        voucher = ::Vouchers::UseCases::Create.new(voucher_deserializer).call
        render json: ::Vouchers::Representers::Single.new(voucher).call, status: :created
      end

      def redeem
        voucher = ::Vouchers::Model.new
        authorize([:api, :v1, voucher])
        redeem = ::Vouchers::UseCases::Redeem.new(purchase_params).call
        render json: { success: 'redeemed' }
      end

      def purchase
        voucher = ::Vouchers::Model.new
        authorize([:api, :v1, voucher])
        ::Vouchers::UseCases::Purchase.new(purchase_params).call
        render json: { purchased: 'success' }
      end

      def update
        voucher = ::Vouchers::Model.new
        authorize([:api, :v1, voucher])
        ::Vouchers::UseCases::Update.new(voucher_deserializer, params[:id]).call
        voucher = ::Vouchers::VoucherRepository.new.find_by_id(params[:id])
        render json: ::Vouchers::Representers::Single.new(voucher).call
      end

      private

      def voucher_deserializer
        {
          points_required: params['data']['attributes']['points_required'].to_i,
          expiration_date: DateTime.parse(params['data']['attributes']['expiration_date']),
          code: params['data']['attributes']['code'],
          description: params['data']['attributes']['description']
        }
      end

      def purchase_params
        {
          user_id: params['data']['attributes']['user_id'],
          voucher_ids: params['data']['attributes']['voucher_ids']
        }
      end
    end
  end
end
