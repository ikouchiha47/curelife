require_relative 'dotenv.rb'

$config = Dotenv.read('.env.local')

Razorpay.setup($config.fetch('RAZORPAY_API'), $config.fetch('RAZORPAY_SECRET'))

