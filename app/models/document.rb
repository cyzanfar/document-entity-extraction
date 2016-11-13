class Document
  include Neo4j::ActiveNode
  include Neo4jrb::Paperclip

  has_neo4jrb_attached_file :file
  validates_attachment_content_type :file, content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif", "application/pdf","application/msword", "text/plain"]
  validates_attachment :file, presence: true

  property :text, type: String
  property :created_at
  property :updated_at
  has_many :out, :terminologies, type: :HAS_TERMINOLOGY, model_class: :Terminology

  after_create :read_file

  def read_file
    file = self.file.queued_for_write[:original]
    self.text = extract_text_from_pdf(file)
    self.extract_entities
  end

  def extract_entities
    terms = EntityExtraction.new self.text, Terminology::SUBJECTS
    return if terminologies = terms.terminologies.nil?

    terminologies.each do |term|
      tech = Terminology.find_or_create_by(subject: 'technology', name: term)
      self.terminologies << tech
    end
  end

  private

  def extract_text_from_pdf(file)
    reader = PDF::Reader.new(file.path)
    reader.pages.map(&:text).join(" ")
  end
end
