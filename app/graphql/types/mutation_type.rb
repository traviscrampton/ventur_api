Types::MutationType = GraphQL::ObjectType.define do
  name "Mutation"

  field :Login, function: Resolvers::Auth::Login.new

  # Journals
  field :CreateJournal, function: Resolvers::Journals::CreateJournal.new
  field :UpdateJournal, function: Resolvers::Journals::UpdateJournal.new
  field :DeleteJournal, function: Resolvers::Journals::DeleteJournal.new

  # Chapters
  field :CreateChapter, function: Resolvers::Chapters::CreateChapter.new
  field :UpdateChapter, function: Resolvers::Chapters::UpdateChapter.new
  field :DeleteChapter, function: Resolvers::Chapters::DeleteChapter.new
end
