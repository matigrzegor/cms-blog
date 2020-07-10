module Paginatable

    def page(num)
        self.order('id desc').last(20 * num).limit(num)
    end

end
