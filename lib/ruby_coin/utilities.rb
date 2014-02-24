module RubyCoin
  module Utilities
    def extract_options!(array)
      if array.last.is_a?(Hash)
        array.pop
      else
        {}
      end
    end
  end
end
