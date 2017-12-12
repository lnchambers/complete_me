require './lib/complete_me'

cm = CompleteMe.new
dictionary = File.read("/usr/share/dict/words")
addresses  = "../complete_me/data/addresses.csv"
cm.populate(dictionary)
cm.populate_from_csv_file(addresses)

Shoes.app(title: "CompleteMe", width: 550) do
  background "#99ffcc".."#00b359"
  flow(margin: [15, 15, 15, 5]) do
    para("Enter the start of a word to see suggestions.")
  end
  flow(margin: [15, 0, 15, 15]) do
    @word = edit_line
    @suggest_button = button "Suggest"

    button "Clear" do
      @results.clear
    end
  end

  @suggest_button.click do
    @results.clear if @results
    @suggestions = cm.suggest(@word.text)
    @results = flow(margin: [15, 0, 15, 0]) do
      @suggestions.each do |word|
        para(
          link(word, stroke: "black").click do
            cm.select(@prefix.text, word)
          end
        )
      end
    end
  end
end
