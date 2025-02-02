class StoreSerializer
  include JSONAPI::Serializer

  attributes :name, :owner
end
