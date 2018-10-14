class ShortenUrl < ApplicationRecord
	URL_LENGTH = 6
	before_create :generate_url

	def simplify
		# remove wording of https, http
		url = self.original_url.strip.downcase.gsub(/(https:\/\/)|(http:\/\/)/, "")
		if PublicSuffix.valid?(url) # check integrity using public suffix gem
			self.simplified_url = "http://" + PublicSuffix.domain(url)
		else
			errors.add(:original_url, {:error => 'Invalid URL'})
		end
	end

	def check_exist
		db_url = ShortenUrl.find_by_simplified_url(self.simplified_url)
		if !db_url.nil?
			self.short_url = db_url.short_url
			errors.add(:short_url, {:warning => 'This URL is already exists'})
		end
	end

	def generate_url
		# generate random character for short url
		new_url = ([*('a'..'b'), *('0'..'9')]).sample(URL_LENGTH).join
		# check db if random if exists
		db_url = ShortenUrl.find_by_short_url(new_url)
		if db_url.nil?
			self.short_url = new_url
		else
			self.generate_url # re-generate random character if already exists
		end
	end
end
