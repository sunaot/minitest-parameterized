require "minitest/parameterized/version"
require 'securerandom'

module Minitest
  module Parameterized
    def parameterized(message = 'with params:', &block)
      @spec = Spec.new
      enable_data_method(@spec, message)
      block.call(@spec)
    end

    private
    def enable_data_method(spec, message)
      klass = class << self; self; end
      if klass.method_defined?(:data)
        klass.remove_method(:data)
      end
      klass.define_method :data do |dataset|
        module_eval do
          describe "#{message}##{SecureRandom.hex(8)}" do
            subject(&spec.when_proc)
            spec.domains.each.with_index do |name, i|
              let(name) { dataset[i] }
            end

            it(&spec.then_proc)
          end
        end
      end
    end

    class Spec
      def initialize
        @names = []
        @when = proc { raise '`when` should be defined.' }
        @then = proc { raise '`then` should be defined.' }
      end

      def where(names)
        @names = names.reject {|name| %w( | || ).include?(name) }
      end

      def when(&block)
        @when = block
      end

      def then(&block)
        @then = block
      end

      def domains
        raise '`where` params should be defines.' unless @names.length > 0
        @names.map(&:to_sym)
      end

      def when_proc
        @when
      end

      def then_proc
        @then
      end
    end
  end
end
