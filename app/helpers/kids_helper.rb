module KidsHelper
  def kid_honorific(sex)
    sex == "男の子" ? "くん" : "ちゃん"
  end
end
