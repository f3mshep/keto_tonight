
  class Float

      def to_mixed
        return self.to_i if self == self.to_i
        amount = self.to_r.rationalize(0.05)
        amount_as_integer = amount.to_i
        if (amount_as_integer != amount.to_f) && (amount_as_integer > 0)
          fraction = amount - amount_as_integer
          "#{amount_as_integer} #{fraction}"
        else
          amount.to_s
        end
      end

  end
