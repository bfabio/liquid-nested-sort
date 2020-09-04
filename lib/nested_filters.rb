# frozen_string_literal: true

require 'liquid/errors'

module LiquidUtils
  def self.nil_safe_compare(a, b)
    if !a.nil? && !b.nil?
      a <=> b
    else
      a.nil? ? 1 : -1
    end
  end

  def self.nil_safe_casecmp(a, b)
    if !a.nil? && !b.nil?
      a.to_s.casecmp(b.to_s)
    else
      a.nil? ? 1 : -1
    end
  end
end

module InputIterator
  def self.new(input)
    if input.is_a?(Array)
      input.flatten
    elsif input.is_a?(Hash)
      [input]
    elsif input.is_a?(Enumerable)
      input
    else
      Array(input)
    end
  end
end

module NestedFilters
  include Liquid

  def nested_sort(input, property = nil)
    ary = InputIterator.new(input)

    return [] if ary.empty?

    if property.nil?
      ary.sort do |a, b|
        LiquidUtils.nil_safe_compare(a, b)
      end
    elsif ary.all? { |el| el.respond_to?(:[]) }
      begin
        ary.sort { |a, b| LiquidUtils.nil_safe_compare(a[property], b[property]) }
      rescue TypeError
        raise Liquid::ArgumentError, "cannot select the property '#{property}'"
      end
    end
  end

  def nested_sort_natural(input, property = nil)
    ary = InputIterator.new(input)

    return [] if ary.empty?

    if property.nil?
      ary.sort do |a, b|
        LiquidUtils.nil_safe_casecmp(a, b)
      end
    elsif ary.all? { |el| el.respond_to?(:[]) }
      begin
        ary.sort { |a, b| LiquidUtils.nil_safe_casecmp(a[property], b[property]) }
      rescue TypeError
        raise Liquid::ArgumentError, "cannot select the property '#{property}'"
      end
    end
  end
end
