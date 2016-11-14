class Terminology
  include Neo4j::ActiveNode

  property :name, type: String
  property :subject, type: String
  property :created_at
  property :updated_at

  validates :name, uniqueness: true

  has_many :in, :documents, origin: :terminologies

  SUBJECTS = ["Technology", "Programming Language"]
end
