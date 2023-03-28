# frozen_string_literal: true

module Types
  class VegetableType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: true
    field :description, String, null: true
    field :sun, String, null: true
    field :water, String, null: true
    field :row_spacing, String, null: true
    field :seed_spacing, String, null: true
    field :growing_duration, String, null: true
    field :image, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
