class ShortenUrlsController < ApplicationController
	def index
		# nothing to do on index
	end

	def add
		# create data
		url_obj = ShortenUrl.new
		url_obj.original_url = params[:original_url]
		url_obj.simplify
		if !url_obj.simplified_url.nil?
			url_obj.check_exist
			if url_obj.short_url.nil?
				url_obj.save
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
			"errors" => url_obj.errors.messages
		}
		render json: result.to_json
	end

	def show
		url = ShortenUrl.find_by_short_url(params[:short_url])
		if !url.nil?
			redirect_to url.simplified_url
		else
			redirect_to root_path
		end
	end

end
