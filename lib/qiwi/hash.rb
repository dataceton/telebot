module Qiwi
  module Hash
    Hash.class_eval do 
      def comment
          self["data"].first["comment"]
      end

      def amount
        self["data"].first["sum"]["amount"]
      end

      def txn_id
        self["data"].first["txnId"]
      end
    end
  end
end