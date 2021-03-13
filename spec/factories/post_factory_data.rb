FactoryBot.define do
  factory :post do
    description {'AAAAA'} # default values
    user_id {'1111'}
    created_at {10.years.ago}
    updated_at {10.years.ago}
  end
end