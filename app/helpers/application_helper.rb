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

	def copy_to_correct_month(hour)
		if hour.date.strftime("%m") == "01"
			current_user.janhours.create(date: hour.date, numhours: hour.numhours)
			redirect_to janhours_path
		end
		if hour.date.strftime("%m") == "02"
			current_user.febhours.create(date: hour.date, numhours: hour.numhours)
			redirect_to febhours_path
		end
		if hour.date.strftime("%m") == "03"
			current_user.marhours.create(date: hour.date, numhours: hour.numhours)
			redirect_to marhours_path
		end
		hour.destroy
	end
end
