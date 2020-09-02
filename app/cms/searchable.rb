module Searchable
  def textacular_search(search, num)
    num = 1 if num == 0 || num.nil?
    num = Integer(num)

    num_on_page = 20
    num_to_fetch = num * num_on_page

    all_title_search_result = basic_search(title: search).order('created_at desc')
    all_content_search_result = basic_search(content_in_text: search).order('created_at desc')

    title_search_result = all_title_search_result.first(num_to_fetch)[(num_to_fetch - num_on_page)..(num_to_fetch -1)] || []

    if title_search_result.size == 0
      previous_num = num - 1
      num_of_previously_fetched_contents = previous_num * 20 - all_title_search_result.size

      num_to_fetch = num_of_previously_fetched_contents + 20

      content_search_result = all_content_search_result.first(num_to_fetch)[num_of_previously_fetched_contents..(num_to_fetch -1)] || []
    elsif !(title_search_result.size == num_on_page)
      num_to_fetch = num_on_page - title_search_result.size

      content_search_result = all_content_search_result.first(num_to_fetch)
    else
      content_search_result = []
    end

    all_search_result_count = all_title_search_result.size + all_content_search_result.size

    title_and_content_search_result = title_search_result.concat(content_search_result)

    [title_and_content_search_result, all_search_result_count]
  end
end
