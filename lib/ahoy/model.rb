module Ahoy
  module Model
    def visitable(name = :visit, **options)
      class_eval do
        belongs_to(name, class_name: "Ahoy::Visit", optional: true, **safe_options)
        before_create :set_ahoy_visit
      end
      class_eval %{
        def set_ahoy_visit
          self.#{name} ||= RequestStore.store[:ahoy].try(:visit_or_create)
        end
      }
    end
  end
end
