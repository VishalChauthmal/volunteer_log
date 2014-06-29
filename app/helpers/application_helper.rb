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
			if !current_user.janhours.find_by(date: hour.date).nil?
				redirect_to janhours_path, notice: "You already submitted the log for this date."
			else
				current_user.janhours.create(date: hour.date, numhours: hour.numhours)
				flash[:success] = "Volunteer Log updated successfully!"
				redirect_to janhours_path
			end
		end

		if hour.date.strftime("%m") == "02"
			if !current_user.febhours.find_by(date: hour.date).nil?
				redirect_to febhours_path, notice: "You already submitted the log for this date."
			else
				current_user.febhours.create(date: hour.date, numhours: hour.numhours)
				flash[:success] = "Volunteer Log updated successfully!"
				redirect_to febhours_path
			end
		end
		
		if hour.date.strftime("%m") == "03"
			if !current_user.marhours.find_by(date: hour.date).nil?
				redirect_to marhours_path, notice: "You already submitted the log for this date."
			else
				current_user.marhours.create(date: hour.date, numhours: hour.numhours)
				flash[:success] = "Volunteer Log updated successfully!"
				redirect_to marhours_path
			end
		end

		hour.destroy
	end
end
