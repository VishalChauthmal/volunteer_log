module ApplicationHelper

	# Returns the full title on a per page basis
	def full_title(page_title)
		base_title = "Atma Volunteer App"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
	end

	def editpath(hour)
		if hour.date.strftime("%m") == "01"
			return edit_janhour_path(hour)
		end
		if hour.date.strftime("%m") == "02"
			return edit_febhour_path(hour)
		end
		if hour.date.strftime("%m") == "03"
			return edit_marhour_path(hour)
		end
	end
end
