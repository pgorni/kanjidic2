require "nokogiri"

class Kanjidic2

	@kanjidic2_file = nil

	def initialize(filename)
		@kanjidic2_file = File.open(filename) { |f| Nokogiri::XML(f) }
	end

	def each_character()
		@kanjidic2_file.css("character").each do |character|
			yield(parse_chr(character))
		end
	end

	def header
		return parse_header(@kanjidic2_file)
	end

	private

	def parse_header(kanjidic2_file)
		header = kanjidic2_file.css("header")
		parsed_header = {}
		["file_version", "database_version", "date_of_creation"].each do |header_elem|
			parsed_header[header_elem] = header.css("#{header_elem}").text
		end
		return parsed_header
	end

	def parse_chr(character)

		# This will be the parsed character.
		this_character = {}

		# character -> literal
		this_character["literal"] = character.css("literal").text

		# character -> codepoint
		this_character["codepoint"] = {}

		character.css("codepoint").css("cp_value").each do |cp_value|
			this_character["codepoint"][cp_value["cp_type"]] = cp_value.text.strip
		end

		# character -> radical
		this_character["radical"] = {}

		character.css("radical").css("rad_value").each do |rad_value|
			this_character["radical"][rad_value["rad_type"]] = rad_value.text.strip
		end

		# character -> misc

		misc_data = character.css("misc")
		this_character["misc"] = {}

		# character -> misc -> grade
		this_character["misc"]["grade"] = misc_data.css("grade").text

		# character -> misc -> stroke_count
		this_character["misc"]["stroke_count"] = misc_data.css("stroke_count").text

		# character -> misc -> variant
		this_character["misc"]["variant"] = {}

		misc_data.css("misc").css("variant").each do |variant|
			this_character["misc"]["variant"][variant["var_type"]] = variant.text.strip
		end

		# character -> misc -> freq
		this_character["misc"]["freq"] = misc_data.css("freq").text

		# character -> misc -> rad_name
		this_character["misc"]["rad_name"] = misc_data.css("rad_name").text

		# character -> misc -> jlpt
		this_character["misc"]["jlpt"] = misc_data.css("jlpt").text

		# character -> dic_number
		this_character["dic_number"] = {}

		character.css("dic_number").css("dic_ref").each do |dic_ref|
			unless dic_ref["dr_type"] == "moro"
				this_character["dic_number"][dic_ref["dr_type"]] = dic_ref.text.strip
			else
				this_character["dic_number"]["moro"] = {}
				this_character["dic_number"]["moro"]["m_vol"] = dic_ref["m_vol"]
				this_character["dic_number"]["moro"]["m_page"] = dic_ref["m_page"]
				this_character["dic_number"]["moro"]["value"] = dic_ref.text.strip
			end
		end

		# character -> query_code
		this_character["query_code"] = {}
		character.css("query_code").css("q_code").each do |q_code|
			this_character["query_code"][q_code["qc_type"]] = q_code.text.strip
		end

		# character -> reading_meaning
		reading_meaning_data = character.css("reading_meaning")
		this_character["reading_meaning"] = {}

		# character -> reading_meaning -> rmgroup
		this_character["reading_meaning"]["rmgroup"] = {}
		this_character["reading_meaning"]["rmgroup"]["reading"] = {}
		this_character["reading_meaning"]["rmgroup"]["meaning"] = {}

		# character -> reading_meaning -> rmgroup -> reading
		reading_meaning_data.css("rmgroup").css("reading").each do |reading|
			unless ["ja_on", "ja_kun"].include? reading["r_type"]
				this_character["reading_meaning"]["rmgroup"]["reading"][reading["r_type"]] = reading.text.strip
			else
				if reading["r_type"] == "ja_on"
					this_character["reading_meaning"]["rmgroup"]["reading"]["ja_on"] = {}
					this_character["reading_meaning"]["rmgroup"]["reading"]["ja_on"]["on_type"] = reading["on_type"]
					this_character["reading_meaning"]["rmgroup"]["reading"]["ja_on"]["r_status"] = reading["r_status"]
					this_character["reading_meaning"]["rmgroup"]["reading"]["ja_on"]["value"] = reading.text.strip
				else
					this_character["reading_meaning"]["rmgroup"]["reading"]["ja_kun"] = {}
					this_character["reading_meaning"]["rmgroup"]["reading"]["ja_kun"]["r_status"] = reading["r_status"]
					this_character["reading_meaning"]["rmgroup"]["reading"]["ja_kun"]["value"] = reading.text.strip
				end
			end
		end

		# character -> reading_meaning -> rmgroup -> meaning
		this_character["reading_meaning"]["rmgroup"]["meaning"]["en"] = []
		this_character["reading_meaning"]["rmgroup"]["meaning"]["fr"] = []
		this_character["reading_meaning"]["rmgroup"]["meaning"]["es"] = []
		this_character["reading_meaning"]["rmgroup"]["meaning"]["pt"] = []

		reading_meaning_data.css("rmgroup").css("meaning").each do |meaning|

			if meaning["m_lang"].nil?
				this_character["reading_meaning"]["rmgroup"]["meaning"]["en"] << meaning.text.strip
			else
				this_character["reading_meaning"]["rmgroup"]["meaning"][meaning["m_lang"]] << meaning.text.strip
			end
		end

		# character -> reading_meaning -> nanori
		this_character["reading_meaning"]["nanori"] = []

		reading_meaning_data.css("nanori").each do |nanori|
			this_character["reading_meaning"]["nanori"] << nanori.text.strip
		end

		return this_character
	end

end