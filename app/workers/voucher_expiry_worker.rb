class VoucherExpiryWorker
  include Sidekiq::Worker
  def perform
    vouchers = Vouchers::VoucherRepository.where(expiration_date < Date.today)
    vouchers.map do |voucher|
      Rails.logger.error "voucher id: #{voucher.id} still active!!!" unless voucher.update!(active: false)
    end
  end
end
