puts "Populating users"

Patient.create!(
  salutation: 'Mr',
  name: 'Alex',
  country_code: '91',
  phone: '9836870428',
  birthdate: DateTime.parse('20-06-1992'),
  password: 'abcd1234',
  password_confirmation: 'abcd1234'
)

