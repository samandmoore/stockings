namespace :matches do
  desc "Scores any matches that have expired"
  task score: [:environment] do
    MatchEvaluator.new.evaluate_all
  end
end
