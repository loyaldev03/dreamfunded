json.array!(@members) do |member|
  json.extract! member, :id, :name, :summary, :fullbio, :title, :rank
  json.url member_url(member, format: :json)
end
