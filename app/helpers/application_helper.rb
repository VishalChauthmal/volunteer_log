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
		if hour.date.strftime("%m") == "04"
			return edit_aprhour_path(hour)
		end
		if hour.date.strftime("%m") == "05"
			return edit_mayhour_path(hour)
		end
		if hour.date.strftime("%m") == "06"
			return edit_junhour_path(hour)
		end
		if hour.date.strftime("%m") == "07"
			return edit_julhour_path(hour)
		end
		if hour.date.strftime("%m") == "08"
			return edit_aughour_path(hour)
		end
		if hour.date.strftime("%m") == "09"
			return edit_sephour_path(hour)
		end
		if hour.date.strftime("%m") == "10"
			return edit_octhour_path(hour)
		end
		if hour.date.strftime("%m") == "11"
			return edit_novhour_path(hour)
		end
		if hour.date.strftime("%m") == "12"
			return edit_dechour_path(hour)
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

		if hour.date.strftime("%m") == "04"
			if !current_user.aprhours.find_by(date: hour.date).nil?
				redirect_to aprhours_path, notice: "You already submitted the log for this date."
			else
				current_user.aprhours.create(date: hour.date, numhours: hour.numhours)
				flash[:success] = "Volunteer Log updated successfully!"
				redirect_to aprhours_path
			end
		end

		if hour.date.strftime("%m") == "05"
			if !current_user.mayhours.find_by(date: hour.date).nil?
				redirect_to mayhours_path, notice: "You already submitted the log for this date."
			else
				current_user.mayhours.create(date: hour.date, numhours: hour.numhours)
				flash[:success] = "Volunteer Log updated successfully!"
				redirect_to mayhours_path
			end
		end

		if hour.date.strftime("%m") == "06"
			if !current_user.junhours.find_by(date: hour.date).nil?
				redirect_to junhours_path, notice: "You already submitted the log for this date."
			else
				current_user.junhours.create(date: hour.date, numhours: hour.numhours)
				flash[:success] = "Volunteer Log updated successfully!"
				redirect_to junhours_path
			end
		end

		if hour.date.strftime("%m") == "07"
			if !current_user.julhours.find_by(date: hour.date).nil?
				redirect_to julhours_path, notice: "You already submitted the log for this date."
			else
				current_user.julhours.create(date: hour.date, numhours: hour.numhours)
				flash[:success] = "Volunteer Log updated successfully!"
				redirect_to julhours_path
			end
		end

		if hour.date.strftime("%m") == "08"
			if !current_user.aughours.find_by(date: hour.date).nil?
				redirect_to aughours_path, notice: "You already submitted the log for this date."
			else
				current_user.aughours.create(date: hour.date, numhours: hour.numhours)
				flash[:success] = "Volunteer Log updated successfully!"
				redirect_to aughours_path
			end
		end

		if hour.date.strftime("%m") == "09"
			if !current_user.sephours.find_by(date: hour.date).nil?
				redirect_to sephours_path, notice: "You already submitted the log for this date."
			else
				current_user.sephours.create(date: hour.date, numhours: hour.numhours)
				flash[:success] = "Volunteer Log updated successfully!"
				redirect_to sephours_path
			end
		end

		if hour.date.strftime("%m") == "10"
			if !current_user.octhours.find_by(date: hour.date).nil?
				redirect_to octhours_path, notice: "You already submitted the log for this date."
			else
				current_user.octhours.create(date: hour.date, numhours: hour.numhours)
				flash[:success] = "Volunteer Log updated successfully!"
				redirect_to octhours_path
			end
		end

		if hour.date.strftime("%m") == "11"
			if !current_user.novhours.find_by(date: hour.date).nil?
				redirect_to novhours_path, notice: "You already submitted the log for this date."
			else
				current_user.novhours.create(date: hour.date, numhours: hour.numhours)
				flash[:success] = "Volunteer Log updated successfully!"
				redirect_to novhours_path
			end
		end

		if hour.date.strftime("%m") == "12"
			if !current_user.dechours.find_by(date: hour.date).nil?
				redirect_to dechours_path, notice: "You already submitted the log for this date."
			else
				current_user.dechours.create(date: hour.date, numhours: hour.numhours)
				flash[:success] = "Volunteer Log updated successfully!"
				redirect_to dechours_path
			end
		end

		hour.destroy
	end
end
