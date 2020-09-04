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

  def self.nested_respond_to?(input, property)
    return true if property.empty?

    p = property.split('.').first
    q = property[/#{p}.?([\w.]*)/, 1]

    return nested_respond_to?(input[p], q) if input.respond_to?(:[]) && accepts?(input, p)
    return nested_respond_to?(input.send(p), q) if input.respond_to?(p)

    false
  end

  def self.nested_send(input, property)
    return input if property.empty?

    p = property.split('.').first
    q = property[/#{p}.?([\w.]*)/, 1]

    return nested_send(input[p], q) if input.respond_to?(:[]) && accepts?(input, p)
    return nested_send(input.send(p), q) if input.respond_to?(p)

    nil
  end

  def self.accepts?(input, index)
    !input[index].nil?
  rescue TypeError
    false
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
    elsif property.include?('.') && LiquidUtils.nested_respond_to?(ary.first, property)
      ary.sort do |a, b|
        LiquidUtils.nil_safe_compare(LiquidUtils.nested_send(a, property), LiquidUtils.nested_send(b, property))
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
    elsif property.include?('.') && LiquidUtils.nested_respond_to?(ary.first, property)
      ary.sort do |a, b|
        LiquidUtils.nil_safe_casecmp(LiquidUtils.nested_send(a, property), LiquidUtils.nested_send(b, property))
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
