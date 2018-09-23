class ShortenUrlsController < ApplicationController
	def add
		errors = Array.new

		# create data
		url_obj = ShortenUrl.new
		url_obj.original_url = params[:original_url]
		url_obj.simplify
		if url_obj.simplified_url.nil?
			errors << {"error" => "Invalid URL"}
		else
			url_obj.check_exist
			if url_obj.short_url.nil?
				url_obj.save
			else
				errors << {"warning" => "This URL is already exists"}
			end
		end

		# return data
		if !url_obj.short_url.nil?
			short_url = request.host_with_port + '/' + url_obj.short_url.to_s
		end

		result = {
			"link" => {
				"url" => url_obj.original_url,
				"short_url" => short_url
			},
			"errors" => errors
		}
		render json: result.to_json
	end
end
