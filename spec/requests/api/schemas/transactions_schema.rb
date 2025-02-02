module TransactionsSchema
  def self.schema
    {
      type:       :object,
      properties: {
        data:       {
          type:  :array,
          items: TransactionSchema.transaction_data_schema
        },
        included:   {
          type:  :array,
          items: StoreSchema.schema
        },
        pagination: {
          type:       :object,
          properties: {
            count:  { type: :integer },
            page: { type: :integer },
            pages:  { type: :integer },
            next:    { types: [ :integer, nil ] },
            prev:    { types: [ :integer, nil ] }
          }
        }
      }
    }
  end
end
