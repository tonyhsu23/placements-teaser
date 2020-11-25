file = File.read('public/placements_teaser_data.json')
data = JSON.parse(file)

puts "Importing data, please wait..."

ActiveRecord::Base.transaction do
  data.each_with_index do |item|
    campaign = Campaign.find_or_create_by!(id: item['campaign_id'],
                                           name: item['campaign_name'])

    line_item_params = item.slice(*%w[id booked_amount actual_amount adjustments])
                           .merge(name: item['line_item_name'])

    campaign.line_items.create!(line_item_params)
  end
end
