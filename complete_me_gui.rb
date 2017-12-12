require './lib/complete_me'

cm = CompleteMe.new
dictionary = File.read("/usr/share/dict/words")
addresses  = "../complete_me/data/addresses.csv"
cm.populate(dictionary)
cm.populate_from_csv_file(addresses)

Shoes.app(title: "CompleteMe", width: 550) do
  background "#99ffcc".."#00b359"
  @complete_me_png = image(
      "http://www.sandboxthreads.com/media/catalog/product/cache/1/image/510x/602f0fa2c1f0d1ba5e241f914e856ff9/g/a/galaga_3.png",
      top:  20,
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
            cm.select(@prefix.text, word)
          end
        )
      end
    end
  end
end
