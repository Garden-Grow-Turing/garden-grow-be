module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :vegetables_by_zipcode, Types::ZipcodeResultType, null: false do
      description 'Returns a zone and basic vegetable details'
      argument :zipcode, String, required: true
    end

    field :vegetable_details, Types::VegetableType, null: false do
      description 'return details about a specific vegetable'
      argument :vegetable_id, String, required: true
    end

    def vegetables_by_zipcode(args)
      zone = get_grow_zone(args)

      {
        grow_zone: zone,
        vegetables: Vegetable.all
      }
    end

    def vegetable_details(args)
      Vegetable.find(args[:vegetable_id])
    end

    private

    def get_grow_zone(args)
      Rails.cache.fetch("grow_zone_query-#{args[:zipcode]}", expires_in: 24.hours) do
        GrowZoneFacade.get_zone(args[:zipcode])
      end
    end
  end
end
