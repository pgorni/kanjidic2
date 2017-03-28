# Kanjidic2

This gem makes parsing [KANJIDIC2](http://www.edrdg.org/kanjidic/kanjd2index.html) easier. See example usage for details.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'kanjidic2'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kanjidic2

And use it in your application:
	
```ruby
require 'kanjidic2'
```


## Dependencies

This gem depends on `nokogiri` for XML parsing.

## Usage

Example code:

```ruby
require "kanjidic2"

kanjidic2 = Kanjidic2.new("kanjidic2.xml")

kanjidic2.each_character do |character|
	p character
end
```

Example output:

`{"literal"=>"亜", "codepoint"=>{"ucs"=>"4e9c", "jis208"=>"16-01"}, "radical"=>{"classical"=>"7", "nelson_c"=>"1"}, "misc"=>{"grade"=>"8", "stroke_count"=>"7", "variant"=>{"jis208"=>"48-19"}, "freq"=>"1509", "rad_name"=>"", "jlpt"=>"1"}, "dic_number"=>{"nelson_c"=>"43", "nelson_n"=>"81", "halpern_njecd"=>"3540", "halpern_kkd"=>"4354", "halpern_kkld"=>"2204", "halpern_kkld_2ed"=>"2966", "heisig"=>"1809", "heisig6"=>"1950", "gakken"=>"1331", "oneill_names"=>"525", "oneill_kk"=>"1788", "moro"=>{"m_vol"=>"1", "m_page"=>"0525", "value"=>"272"}, "henshall"=>"997", "sh_kk"=>"1616", "sh_kk2"=>"1724", "jf_cards"=>"1032", "tutt_cards"=>"1092", "kanji_in_context"=>"1818", "kodansha_compact"=>"35", "maniette"=>"1827"}, "query_code"=>{"skip"=>"4-7-1", "sh_desc"=>"0a7.14", "four_corner"=>"1010.6", "deroo"=>"3273"}, "reading_meaning"=>{"rmgroup"=>{"reading"=>{"pinyin"=>"ya4", "korean_r"=>"a", "korean_h"=>"아", "vietnam"=>"Á", "ja_on"=>{"on_type"=>nil, "r_status"=>nil, "value"=>"ア"}, "ja_kun"=>{"r_status"=>nil, "value"=>"つ.ぐ"}}, "meaning"=>{"en"=>["Asia", "rank next", "come after", "-ous"], "fr"=>["Asie", "suivant", "sub-", "sous-"], "es"=>["pref. para indicar", "venir después de", "Asia"], "pt"=>["Ásia", "próxima", "o que vem depois", "-ous"]}}, "nanori"=>["や", "つぎ", "つぐ"]}}
`

The output resembles the [DTD](http://www.edrdg.org/kanjidic/kanjidic2_dtdh.html) quite closely. Consult the DTD for details.

You can also access the header in its parsed form:

```ruby
require "kanjidic2"

kanjidic2 = Kanjidic2.new("kanjidic2.xml")

p kanjidic2.header

end
```

Example output:

`{"file_version"=>"4", "database_version"=>"2017-064", "date_of_creation"=>"2017-03-05"}`

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pgorni/kanjidic2.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


