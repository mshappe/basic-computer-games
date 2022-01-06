module Utilities
  # This was
  # DEF FNR(R)=INT(RND(R)*7.98+1.01)
  # BASIC RND(1) generated a float between 0 and 1
  # BASIC arrays were 1-based
  # We use `rand` and subtract 1
  def special_random(one_based: false)
    base = rand * 7.98
    base += 1.01 if one_based
    base.to_i
  end
end
