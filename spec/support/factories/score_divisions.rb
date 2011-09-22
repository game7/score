# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :division, :class => Score::Division do |d|
    d.name = "A Division"
  end
end
