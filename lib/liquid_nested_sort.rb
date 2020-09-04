# frozen_string_literal: true

module NestedFilter
  def nested_sort(input, property = nil)
    ary = InputIterator.new(input, context)

    return [] if ary.empty?

    if property.nil?
      ary.sort do |a, b|
        nil_safe_compare(a, b)
      end
    elsif ary.all? { |el| el.respond_to?(:[]) }
      begin
        ary.sort { |a, b| nil_safe_compare(a[property], b[property]) }
      rescue TypeError
        raise_property_error(property)
      end
    end
  end

  def nested_sort_natural(input, property = nil)
    ary = InputIterator.new(input, context)

    return [] if ary.empty?

    if property.nil?
      ary.sort do |a, b|
        nil_safe_compare(a, b)
      end
    elsif ary.all? { |el| el.respond_to?(:[]) }
      begin
        ary.sort { |a, b| nil_safe_compare(a[property], b[property]) }
      rescue TypeError
        raise_property_error(property)
      end
    end
  end
end

Liquid::Template.register_filter(NestedFilter)
