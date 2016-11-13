class Terminology
  include Neo4j::ActiveNode

  property :name, type: String, constraint: :unique
  property :subject, type: String
  property :created_at
  property :updated_at

  has_many :in, :documents, origin: :terminologies

  SUBJECTS = ["Technology", "Programming Language"]
end
