require 'inherits_attrs/version'
require 'active_record'

module ActiveRecord
  class Base
    cattr_accessor :attrs_to_inherit

    def self.hide_uninherited_attributes?
      false
    end

    def self.hides_uninherited_attributes
      define_singleton_method 'hide_uninherited_attributes?' do
        true
      end
      true
    end

    def self.inherits_attributes(*attrs_to_inherit)
      (attrs_to_inherit += [:id, :type, :created_at, :updated_at]).uniq!
      self.attrs_to_inherit = attrs_to_inherit

      all_attrs = self.attribute_names.collect { |attr| attr.to_sym }
      (all_attrs - self.attrs_to_inherit).each do |attr_name|
        define_method attr_name do
          raise inheritance_error(attr_name)
        end

        define_method "#{attr_name}=" do |a|
          raise inheritance_error(attr_name)
        end
      end

      define_method('to_json') do
        Hash[ self.attrs_to_inherit.collect { |attr_name| [attr_name, self[attr_name]] } ].to_json
      end

      define_singleton_method('hides_uninherited_attributes') do
        raise NoMethodError, "hides_uninherited_attributes can only be used in the base class, #{self.superclass.name}"
      end

      if self.hide_uninherited_attributes?
        define_singleton_method("inspect") do
          if table_exists?
            attrs_type = Hash[ *columns.collect { |c| [ c.name.to_sym, c.type.to_s ] }.flatten ]
            inspection = self.attrs_to_inherit.map { |name| "#{name}: #{attrs_type[name]}" } * ', '
            "#{self.name}(#{inspection})"
          else
            "#{self.name}(Table doesn't exist)"
          end
        end

        define_method("inspect") do
          inspection = self.class.attrs_to_inherit.collect { |name| "#{name}: #{attribute_for_inspect(name)}" }.join(', ')
          "#<#{self.class} #{inspection}>"
        end
      end

    end

    private

    def inheritance_error(attr_name)
      "Cannot access '#{attr_name}' because it was not inherited. Use :inherits_from in the model if you want to inherit this attribute."
    end

  end
end

