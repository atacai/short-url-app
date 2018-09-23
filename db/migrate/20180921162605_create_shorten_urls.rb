class CreateShortenUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :shorten_urls do |t|
      t.string :original_url
      t.string :simplified_url
      t.string :short_url
      t.timestamps
    end
  end
end
