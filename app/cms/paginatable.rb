module Paginatable
  def page(num)
    num = 1 if num == 0 || num.nil?
    num = Integer(num)

    num_on_page = 20
    num_to_fetch = num * num_on_page

    self.order('id desc').first(num_to_fetch)[(num_to_fetch - num_on_page)..(num_to_fetch -1)]
  rescue
    nil
  end
end
