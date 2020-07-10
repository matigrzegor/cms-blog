module Paginatable

    def page(num)
        num = 1 if num.nil? || num == 0
        return nil unless num.is_a? Integer

        num_on_page = 20
        num_to_fetch = num * num_on_page
        
        self.order('id desc').first(num_to_fetch)[(num_to_fetch - num_on_page)..(num_to_fetch -1)]
    end

end
