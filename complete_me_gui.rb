require './lib/complete_me'

cm = CompleteMe.new
dictionary = File.read("/usr/share/dict/words")
addresses  = "../complete_me/data/addresses.csv"
cm.populate(dictionary)
cm.populate_from_csv_file(addresses)

Shoes.app(title: "CompleteMe", width: 550) do
  background "#00b359".."#99ffcc"
  @complete_me_png = image(
      "./data/rsz_1galaga_3.png",
      top: 1,
      right: 20
    )
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
            cm.select(@word.text, word) && @results.clear


          end
        )
      end
    end
  end
end

# TODO when user selects a word, cache of links is cleared.
# TODO when user presses enter the suggestions hits
