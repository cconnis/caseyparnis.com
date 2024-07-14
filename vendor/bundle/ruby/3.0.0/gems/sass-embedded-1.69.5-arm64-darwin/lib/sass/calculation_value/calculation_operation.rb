# frozen_string_literal: true

module Sass
  module CalculationValue
    # A binary operation that can appear in a SassCalculation.
    #
    # @see https://sass-lang.com/documentation/js-api/classes/calculationoperation/
    class CalculationOperation
      include CalculationValue

      OPERATORS = ['+', '-', '*', '/'].freeze

      private_constant :OPERATORS

      # @param operator [::String]
      # @param left [CalculationValue]
      # @param right [CalculationValue]
      def initialize(operator, left, right)
        raise Sass::ScriptError, "Invalid operator: #{operator}" unless OPERATORS.include?(operator)

        left.assert_calculation_value
        right.assert_calculation_value

        @operator = operator.freeze
        @left = left.freeze
        @right = right.freeze
      end

      # @return [::String]
      attr_reader :operator

      # @return [CalculationValue]
      attr_reader :left

      # @return [CalculationValue]
      attr_reader :right

      # @return [::Boolean]
      def ==(other)
        other.is_a?(Sass::CalculationValue::CalculationOperation) &&
          other.operator == operator &&
          other.left == left &&
          other.right == right
      end

      # @return [Integer]
      def hash
        @hash ||= [operator, left, right].hash
      end
    end
  end
end
