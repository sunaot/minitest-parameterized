require "test_helper"
require 'minitest-power_assert'

class Minitest::ParameterizedTest < Minitest::Test
  class TicketPrice
    def self.price(age)
      case age
      when 0..14
        0
      when 15..19
        600
      when 20..65
        1800
      else
        400
      end
    end
  end

  describe 'Price' do
    extend Minitest::Parameterized
    parameterized 'with message' do |spec|
      spec.when { TicketPrice.price(age) }
      spec.then do
        assert { subject == price }
      end

      spec.where \
        %w(  age || price )
      data [ 15  ,  600 ]
      data [ 20  , 1800 ]
      data [  0  ,    0 ]
    end

    parameterized do |spec| # with no message
      spec.when { TicketPrice.price(age) }
      spec.then do
        assert { subject == cost }
      end

      spec.where \
        %w(  age || cost )
      data [ 45  ,  1800 ]
      data [ 70  ,   400 ]
    end

    parameterized do |spec|
      describe 'Header separators' do
        spec.when { TicketPrice.price(age) }
        spec.then do
          assert { subject == cost }
        end

        spec.where \
          %w| age , cost |
        data [ 70 ,  400 ]

        spec.where \
          %w( age | cost )
        data [ 45 , 1800 ]

        spec.where \
          %w( age || cost )
        data [ 45 ,  1800 ]
      end
    end

    parameterized do |spec|
      describe 'No when definition' do
        spec.then do
          e = assert_raises RuntimeError do
            subject == cost
          end
          assert { e.message == '`when` should be defined.' }
        end

        spec.where \
          %w( age | cost )
        data [ 70 ,  400 ]
      end
    end
  end
end
