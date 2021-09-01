class VoucherExpiryWorker
  include Sidekiq::Worker
  def perform
    puts "expiring"
  end
end
