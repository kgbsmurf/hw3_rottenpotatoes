# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
	Movie.create!(movie)	
  end
  #flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
	#  flunk "Unimplemented"
	begin
		e1 = Date.parse(e1) 
	  e2 = Date.parse(e2)
		page.body.index(e1.strftime("%F")) < page.body.index(e2.strftime("%F"))
	rescue
			page.body.index(e1) < page.body.index(e2)
  end
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
	rating_list.split(',').each do |checkbox|
		value = 'ratings_'+checkbox.strip
		uncheck == true ? uncheck(value) : check(value)
	end
end


When /^I press "(.*?)" button$/ do |button|
	#pending # express the regexp above with the code you wish you had
	click_button(button)
end

Then /^I should (not )?see ratings: (.*)/ do |not_see, rating|
	#				  pending # express the regexp above with the code you wish you had
	value = rating.split(',').each do |r|
		r.strip!
		if not_see == true 
			then (page.should_not have_content(r)) 
			else (page.should have_content(r))
		end 
	end
end

When /^I uncheck all ratings$/ do
	%w[R G PG-13 PG].each do |rating|
		value = 'ratings_' + rating
		page.uncheck(value)
	end
end

Then /^I should see all of the movies$/ do
	all('#table_id tr > td:nth-child(2)').each do |td|
		%w[R G PG-13 PG].should include td.text
	end
end

Given /^that all checkboxes are checked$/ do
        %w[R G PG-13 PG].each do |rating|
		value = 'ratings_' + rating
        	page.check(value)
	end
end



