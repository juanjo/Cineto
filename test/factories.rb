FactoryGirl.define do
  factory :torrent do
    sequence(:torrent_id) { |n| n }
    added_at Time.now
    is_finished false
    name "Torrent Name"
    size 1000
  end

end