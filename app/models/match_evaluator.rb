class MatchEvaluator

  def evaluate_all
    Match.winnerless.elapsed.each do |m|
      evalulate_match m
    end
  end

  def evalulate_match(match)
    match.entries.each { |entry| entry.grade! }
    match.reload
    winner = match.entries.order(grade: :desc).first
    match.winning_entry = winner
    match.save!
  end
end
