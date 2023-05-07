# frozen_string_literal: true

class Admin::PlanSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :description,
             :price,
             :value
end
