# frozen_string_literal: true

require_relative "solid_errors/version"
require_relative "solid_errors/sanitizer"
require_relative "solid_errors/subscriber"
require_relative "solid_errors/engine"

module SolidErrors
  mattr_accessor :connects_to
  mattr_writer :username
  mattr_writer :password
  mattr_writer :send_emails
  mattr_writer :one_email_per_occurrence
  mattr_writer :email_from
  mattr_writer :email_to
  mattr_writer :email_subject_prefix

  class << self
    # use method instead of attr_accessor to ensure
    # this works if variable set after SolidErrors is loaded
    def username
      @username ||= ENV["SOLIDERRORS_USERNAME"] || @@username
    end

    # use method instead of attr_accessor to ensure
    # this works if variable set after SolidErrors is loaded
    def password
      @password ||= ENV["SOLIDERRORS_PASSWORD"] || @@password
    end

    def send_emails?
      @send_emails ||= ENV["SOLIDERRORS_SEND_EMAILS"] || @@send_emails || false
    end

    # only send one email per occurrence while the issue is Unresolved
    # if the issue was resolved and then reoccurs, another email will be sent
    def one_email_per_occurrence?
      @one_email_per_occurrence ||= ENV["SOLIDERRORS_ONE_EMAIL_PER_OCCURRENCE"] || @@one_email_per_occurrence || false
    end

    def email_from
      @email_from ||= ENV["SOLIDERRORS_EMAIL_FROM"] || @@email_from || "solid_errors@noreply.com"
    end

    def email_to
      @email_to ||= ENV["SOLIDERRORS_EMAIL_TO"] || @@email_to
    end

    def email_subject_prefix
      @email_subject_prefix ||= ENV["SOLIDERRORS_EMAIL_SUBJECT_PREFIX"] || @@email_subject_prefix
    end
  end
end
